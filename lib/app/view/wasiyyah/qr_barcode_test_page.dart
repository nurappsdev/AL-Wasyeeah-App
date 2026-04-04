import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:al_wasyeah/app/core/services/qr_barcode/qr_barcode_service.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';

class QrBarcodeTestPage extends StatefulWidget {
  final String? qrBase64;
  final String? barcodeBase64;

  const QrBarcodeTestPage({
    super.key,
    this.qrBase64,
    this.barcodeBase64,
  });

  @override
  State<QrBarcodeTestPage> createState() => _QrBarcodeTestPageState();
}

class _QrBarcodeTestPageState extends State<QrBarcodeTestPage> {
  File? _selectedImage;
  String? _scanResult;
  bool _isScanning = false;
  bool _showLiveScanner = false;

  // Derived temp files from passed base64
  File? _qrImageFile;
  File? _barcodeImageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _savePassedImages();
  }

  /// Save the passed base64 images to temp files so they can be scanned
  Future<void> _savePassedImages() async {
    final tempDir = await getTemporaryDirectory();

    if (widget.qrBase64 != null && widget.qrBase64!.isNotEmpty) {
      try {
        final qrBytes = base64Decode(widget.qrBase64!);
        final qrFile = File('${tempDir.path}/qr_test_image.png');
        await qrFile.writeAsBytes(qrBytes);
        setState(() => _qrImageFile = qrFile);
      } catch (_) {}
    }

    if (widget.barcodeBase64 != null && widget.barcodeBase64!.isNotEmpty) {
      try {
        // Barcode is SVG base64; decode to SVG string, but for scanning
        // we need a raster image. We'll show it as an info card instead.
        final barcodeBytes = base64Decode(widget.barcodeBase64!);
        final barcodeFile = File('${tempDir.path}/barcode_test_image.svg');
        await barcodeFile.writeAsBytes(barcodeBytes);
        setState(() => _barcodeImageFile = barcodeFile);
      } catch (_) {}
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _scanResult = null;
      });
    }
  }

  Future<void> _scanImage() async {
    if (_selectedImage == null) return;

    setState(() => _isScanning = true);
    final result = await QrBarcodeService.decodeImage(_selectedImage!.path);
    setState(() {
      _scanResult = result;
      _isScanning = false;
    });

    if (result == null) {
      ToastMessage.errorMessageShowToster("No QR or Barcode found in this image.");
    } else {
      ToastMessage.successMessageShowToster("Scan successful!");
    }
  }

  /// Use the passed QR image for scanning
  Future<void> _scanQrImage() async {
    if (_qrImageFile == null) return;

    setState(() {
      _selectedImage = _qrImageFile;
      _isScanning = true;
    });

    final result = await QrBarcodeService.decodeImage(_qrImageFile!.path);
    setState(() {
      _scanResult = result;
      _isScanning = false;
    });

    if (result == null) {
      ToastMessage.errorMessageShowToster("No QR code found in this image.");
    } else {
      ToastMessage.successMessageShowToster("QR Scan successful!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPassedImages = _qrImageFile != null || _barcodeImageFile != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR & Barcode Tester"),
        actions: [
          IconButton(
            icon: Icon(_showLiveScanner ? Icons.image : Icons.camera_alt),
            onPressed: () => setState(() => _showLiveScanner = !_showLiveScanner),
            tooltip: _showLiveScanner ? "Switch to Image Pick" : "Switch to Live Camera",
          ),
        ],
      ),
      body: _showLiveScanner ? _buildLiveScanner() : _buildImagePickerView(hasPassedImages),
    );
  }

  Widget _buildLiveScanner() {
    return Stack(
      children: [
        MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty) {
              final String? code = barcodes.first.displayValue;
              if (code != null) {
                setState(() {
                  _scanResult = code;
                  _showLiveScanner = false;
                });
                ToastMessage.successMessageShowToster("Scanned: $code");
              }
            }
          },
        ),
        const Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "Point at a QR or Barcode",
              style: TextStyle(color: Colors.white, backgroundColor: Colors.black54, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerView(bool hasPassedImages) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Section: Generated QR & Barcode from PDF ===
          if (hasPassedImages) ...[
            const Text(
              "Generated QR & Barcode (from PDF)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // QR Image
                if (_qrImageFile != null)
                  Expanded(
                    child: Column(
                      children: [
                        const Text("QR Code", style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image.file(_qrImageFile!, fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _scanQrImage,
                          icon: const Icon(Icons.qr_code_scanner, size: 18),
                          label: const Text("Scan This QR"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_qrImageFile != null && _barcodeImageFile != null)
                  const SizedBox(width: 12),
                // Barcode Image (SVG - display info)
                if (_barcodeImageFile != null)
                  Expanded(
                    child: Column(
                      children: [
                        const Text("Barcode", style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.barcode_reader, size: 48, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  "Barcode (SVG)\nUse Live Camera to scan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
          ],

          // === Section: Manual Image Pick & Scan ===
          const Text(
            "Test QR/Barcode from PDF Screenshot",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (_selectedImage != null)
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(_selectedImage!, fit: BoxFit.contain),
              ),
            )
          else
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, size: 100, color: Colors.grey),
            ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.photo_library),
            label: const Text("Select Screenshot from Gallery"),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _selectedImage != null && !_isScanning ? _scanImage : null,
            icon: _isScanning
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.qr_code_scanner),
            label: Text(_isScanning ? "Scanning..." : "Decode Selected Image"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          if (_scanResult != null) ...[
            const Text(
              "Scan Result:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                _scanResult!,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
