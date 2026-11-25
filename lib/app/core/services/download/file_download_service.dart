import 'dart:developer';
import 'dart:io';
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

  static Future<void> saveLocalFile(
    String filePath,
    String fileName,
  ) async {
    final source = File(filePath);

    if (!await source.exists()) {
      throw Exception('File does not exist');
    }

    final bytes = await source.readAsBytes();

    await FileSaver.instance.saveToDownloads(
      name: fileName,
      bytes: bytes,
      mimeType: MimeType.pdf,
      subfolder: 'AlWasyeeah',
    );

    log('File saved successfully: $fileName');
  }
}
