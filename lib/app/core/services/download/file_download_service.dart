import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:file_saver/file_saver.dart';
import 'dart:typed_data';

class FileDownloadUtil {
  static Future<void> downloadFile(
    String url,
    String fileName,
    Function(double) onProgress,
  ) async {
    final client = http.Client();

    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception('Download failed: ${response.statusCode}');
      }

      final totalBytes = response.contentLength ?? 0;
      int receivedBytes = 0;

      final bytes = <int>[];

      await for (final chunk in response.stream) {
        bytes.addAll(chunk);
        receivedBytes += chunk.length;

        if (totalBytes > 0) {
          onProgress(receivedBytes / totalBytes * 100);
        }
      }

      final extension = _getExtensionFromContentType(
        response.headers['content-type'],
      );

      final finalName = '$fileName$extension';

      await FileSaver.instance.saveToDownloads(
        name: finalName,
        bytes: Uint8List.fromList(bytes),
        mimeType: MimeType.pdf,
        subfolder: 'AlWasyeeah',
      );

      onProgress(100);
      log('Download completed: $finalName');
    } catch (e, stackTrace) {
      log('Download error: $e $stackTrace');
      rethrow;
    } finally {
      client.close();
    }
  }

  static String _getExtensionFromContentType(String? contentType) {
    if (contentType == null) return '';

    if (contentType.contains('pdf')) return '.pdf';
    if (contentType.contains('png')) return '.png';
    if (contentType.contains('jpeg') || contentType.contains('jpg'))
      return '.jpg';

    return '';
  }
}

// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class FileDownloadUtil {

//   static Future<void> downloadFile(String url, String fileName, Function(double) onProgress) async {
//     final request = http.Request('GET', Uri.parse(url));
//     final response = await request.send();

//     final int totalBytes = response.contentLength ?? 0;
//     int receivedBytes = 0;

//     final directory = Directory('/storage/emulated/0/Download/AlWasyeeah');
//     if (!await directory.exists()) {
//       await directory.create(recursive: true);
//     }

//     try {
//       String extension = _getExtensionFromContentType(response.headers['content-type']);

//       final file = File('${directory.path}/$fileName$extension');
//       final sink = file.openWrite();

//       await for (var chunk in response.stream) {
//         receivedBytes += chunk.length;

//         sink.add(chunk);

//         if (totalBytes > 0) {
//           double progress = (receivedBytes / totalBytes) * 100;
//           onProgress(progress);
//         }
//       }

//       await sink.close();
//       onProgress(100.0);

//       log('File saved at: ${file.path}');
//     } catch (e, s) {
//       log("File save error: $e and $s");
//       rethrow;
//     }
//   }

//   static String _getExtensionFromContentType(String? contentType) {
//     if (contentType == null) return "";

//     if (contentType.contains("png")) return ".png";
//     if (contentType.contains("jpg") || contentType.contains("jpeg")) {
//       return ".jpg";
//     }
//     if (contentType.contains("application/octet-stream")) return ".pdf";
//     if (contentType.contains("pdf")) return ".pdf";
//     // if (contentType.contains("docx")) return ".docx";
//     // if (contentType.contains("doc")) return ".doc";

//     return "";
//   }
// }
