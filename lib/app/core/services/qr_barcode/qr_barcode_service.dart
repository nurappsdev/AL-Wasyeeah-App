import 'dart:convert';
import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrBarcodeService {
  static Future<String> generateQrBase64(Map<String, dynamic> data) async {
    final painter = QrPainter(
      data: jsonEncode(data),
      version: QrVersions.auto,
      gapless: true,
    );

    final image = await painter.toImageData(800);
    final bytes = image!.buffer.asUint8List();

    return base64Encode(bytes);
  }

  static Future<String> generateBarcodeBase64(Map<String, dynamic> data) async {
    final barcode = Barcode.code128();

    final svg = barcode.toSvg(
      jsonEncode(data),
      width: 800,
      height: 200,
      drawText: true,
    );

    final bytes = utf8.encode(svg);
    return base64Encode(Uint8List.fromList(bytes));
  }
}
