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
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: [
          'pdf',
          'png',
          'jpg',
          'jpeg',
        ],
      );

      if (result == null || result.files.single.path == null) {
        return null;
      }

      final platformFile = result.files.single;
      final file = File(platformFile.path!);

      return PickedFileResult(
        file: file,
        fileName: platformFile.name,
        extension: platformFile.extension ?? '',
      );
    } catch (e) {
      log('File picking error: $e');
      return null;
    }
  }
}
