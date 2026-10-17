import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PickedFileResult {
  final File file;
  final String fileName;
  final String extension;

  PickedFileResult({
    required this.file,
    required this.fileName,
    required this.extension,
  });
}

class FilePickerUtil {
  static Future<PickedFileResult?> pickSingleFile() async {
    try {
      final result = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'png',
          'jpg',
          'jpeg',
        ],
      );

      if (result == null || result.path == null) {
        return null;
      }

      return PickedFileResult(
        file: File(result.path!),
        fileName: result.name,
        extension: result.extension ?? '',
      );
    } catch (e) {
      log('File picking error: $e');
      return null;
    }
  }
}
