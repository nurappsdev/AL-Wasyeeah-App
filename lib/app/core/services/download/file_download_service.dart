import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class FileDownloadUtil {
 

  static Future<void> downloadFile(String url, String fileName, Function(double) onProgress) async {
    final request = http.Request('GET', Uri.parse(url));
    final response = await request.send();
    
    final int totalBytes = response.contentLength ?? 0;
    int receivedBytes = 0;

    final directory = Directory('/storage/emulated/0/Download/AlWasyeeah');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    try {
      String extension = _getExtensionFromContentType(response.headers['content-type']);

      final file = File('${directory.path}/$fileName$extension');
      final sink = file.openWrite();

      await for (var chunk in response.stream) {
        receivedBytes += chunk.length;

        sink.add(chunk);

        if (totalBytes > 0) {
          double progress = (receivedBytes / totalBytes) * 100;
          onProgress(progress);
        }
      }

      await sink.close();
      onProgress(100.0);

      log('File saved at: ${file.path}');
    } catch (e, s) {
      log("File save error: $e and $s");
      rethrow;
    }
  }

  static String _getExtensionFromContentType(String? contentType) {
    if (contentType == null) return "";

    if (contentType.contains("png")) return ".png";
    if (contentType.contains("jpg") || contentType.contains("jpeg")) {
      return ".jpg";
    }
    if (contentType.contains("application/octet-stream")) return ".pdf";
    if (contentType.contains("pdf")) return ".pdf";
    // if (contentType.contains("docx")) return ".docx";
    // if (contentType.contains("doc")) return ".doc";

    return "";
  }
}
