import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart' as bw;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrBarcodeService {
  static Future<String> generateQrBase64(Map<String, dynamic> data) async {
    log("QR Data: ${jsonEncode(data)}");
    final painter = QrPainter(
      data: jsonEncode(data),
      version: QrVersions.auto,
      gapless: true,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
    );

    // Render QR on a white background with a quiet zone so scanners can detect it
    const double size = 800;
    const double padding = 40; // Quiet zone
    const double qrSize = size - (padding * 2);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, size, size));

    // Draw white background
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, size, size),
      Paint()..color = const Color(0xFFFFFFFF),
    );

    // Draw QR code centered with padding
    canvas.save();
    canvas.translate(padding, padding);
    painter.paint(canvas, const Size(qrSize, qrSize));
    canvas.restore();

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return base64Encode(bytes);
  }

  static Future<String> generateBarcodeBase64(Map<String, dynamic> data) async {
    final barcode = bw.Barcode.code128();
    final encodedData = base64Encode(utf8.encode(jsonEncode(data)));
    log("Barcode Data: ${jsonEncode(data)}");
    final svg = barcode.toSvg(
      encodedData,
      width: 800,
      height: 200,
      drawText: true,
    );

    final bytes = utf8.encode(svg);
    return base64Encode(Uint8List.fromList(bytes));
  }

  static Future<String?> decodeImage(String filePath) async {
    final controller = MobileScannerController();
    try {
      final BarcodeCapture? capture = await controller.analyzeImage(filePath);
      if (capture != null && capture.barcodes.isNotEmpty) {
        return capture.barcodes.first.displayValue;
      }
    } catch (e) {
      log("Error decoding image: $e");
    } finally {
      controller.dispose();
    }
    return null;
  }
}
