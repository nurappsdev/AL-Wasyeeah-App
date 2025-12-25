import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileDownloadUtil {
  Future<void> downloadFile(
      String url, String fileName, Function(double) onProgress) async {
    final client = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    final response = await client.send(request);

    // Get the total size of the file
    final int totalBytes = response.contentLength ?? 0;
    int receivedBytes = 0;
    List<int> bytes = [];

    // Listen to the stream for progress updates
    response.stream.listen(
      (List<int> chunk) {
        bytes.addAll(chunk);
        receivedBytes += chunk.length;
        // Calculate and report progress
        if (totalBytes > 0) {
          double progress = (receivedBytes / totalBytes) * 100;
          onProgress(progress);
        }
      },
      onDone: () async {
        // Save the file when the download is complete
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(bytes);
        onProgress(100.0); // Signal completion
        print('Download complete. File saved at: ${file.path}');
      },
      onError: (error) {
        print('Download error: $error');
      },
      cancelOnError: true,
    );
  }
}

// import 'dart:io';
// import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:pool/pool.dart';

// class FileDownloadUtil {
//   Future<void> downloadFile(
//     String url,
//     String fileName,
//     Function(double) onProgress,
//   ) async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/$fileName';

//       final request = http.Request('GET', Uri.parse(url));
//       final response = await http.Client().send(request);

//       final totalBytes = response.contentLength ?? 0;
//       int received = 0;

//       final file = File(filePath);
//       final sink = file.openWrite();

//       await response.stream.listen(
//         (chunk) {
//           received += chunk.length;
//           sink.add(chunk);

//           if (totalBytes > 0) {
//             onProgress((received / totalBytes) * 100);
//           }
//         },
//         onDone: () async {
//           await sink.close();
//           onProgress(100);
//         },
//         cancelOnError: true,
//       ).asFuture();
//     } catch (e) {
//       log("Download Error: ${e.toString()}");
//     }
//   }
// }
