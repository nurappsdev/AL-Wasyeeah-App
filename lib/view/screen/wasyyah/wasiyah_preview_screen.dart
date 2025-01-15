// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// class WasiyahPreviewScreen extends StatefulWidget {
//   const WasiyahPreviewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WasiyahPreviewScreen> createState() => _WasiyahPreviewScreenState();
// }
//
// class _WasiyahPreviewScreenState extends State<WasiyahPreviewScreen> {
//   String? pathPDF;
//   final pdf = pw.Document();
//   final diagnosis = "Sample Diagnosis";
//
//   // Styles
//   final headerStyle1 =
//   pw.TextStyle(fontSize: 35, fontWeight: pw.FontWeight.bold);
//   final headerStyle =
//   pw.TextStyle(fontSize: 27, fontWeight: pw.FontWeight.bold);
//   final mediuamStyle = pw.TextStyle(fontSize: 22);
//   final PdfColor containerColor = PdfColor.fromInt(0xFF193664);
//
//   @override
//   void initState() {
//     super.initState();
//     _generateAndSavePDF();
//   }
//   Future<void> _generateAndSavePDF() async {
//     final pdf = pw.Document();
//     final headerStyle = pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold);
//     final mediuamStyle = pw.TextStyle(fontSize: 18);
//     const PdfColor containerColor = PdfColor.fromInt(0xFF193664);
//
//     for (int i = 0; i < 5; i++) {
//       pdf.addPage(
//         pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context context) {
//             return pw.Container(
//               width: PdfPageFormat.a4.width,
//               height: PdfPageFormat.a4.height,
//               child: pw.Column(
//                 mainAxisAlignment: pw.MainAxisAlignment.start,
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Prescription Page ${i + 1}', style: headerStyle),
//                   pw.SizedBox(height: 12),
//                   pw.Container(
//                       height: 4, width: double.infinity, color: containerColor),
//                   pw.SizedBox(height: 16),
//                   pw.Row(
//                     children: [
//                       pw.Text('Prescription No:', style: mediuamStyle),
//                       pw.Text('12345', style: mediuamStyle),
//                     ],
//                   ),
//                   pw.SizedBox(height: 12),
//                   pw.Align(
//                     alignment: pw.Alignment.centerLeft,
//                     child: pw.Text('Patient Information', style: headerStyle),
//                   ),
//                   pw.SizedBox(height: 12),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.SizedBox(
//                         width: 150,
//                         child: pw.Row(children: [
//                           pw.Text('Name: ', style: mediuamStyle),
//                           pw.Text('John Doe', style: mediuamStyle),
//                         ]),
//                       ),
//                       pw.Row(children: [
//                         pw.Text('Age: ', style: mediuamStyle),
//                         pw.Text('30 Years', style: mediuamStyle),
//                       ]),
//                     ],
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Row(children: [
//                     pw.Text('Pharmacy: ', style: mediuamStyle),
//                     pw.Text('Sample Diagnosis', style: mediuamStyle),
//                   ]),
//                   pw.SizedBox(height: 10),
//                   pw.Row(children: [
//                     pw.Text('NPI Number: ', style: mediuamStyle),
//                     pw.Text('123456789', style: mediuamStyle),
//                   ]),
//                   pw.SizedBox(height: 10),
//                   pw.Row(children: [
//                     pw.Text('Doctor Signature: ', style: mediuamStyle),
//                     pw.Text('Dr. Smith', style: mediuamStyle),
//                   ]),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     // Save the PDF to a file
//     final outputDir = await getApplicationDocumentsDirectory();
//     final outputFile = File('${outputDir.path}/prescription.pdf');
//     await outputFile.writeAsBytes(await pdf.save());
//     setState(() {
//       pathPDF = outputFile.path; // Save the file path for later use
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("PDF Preview"),
//         centerTitle: true,
//       ),
//       body: pathPDF == null
//           ? const Center(child: CircularProgressIndicator())
//           : PDFView(
//         filePath: pathPDF!,
//         enableSwipe: true,
//         swipeHorizontal: true,
//         autoSpacing: true,
//         pageSnap: true,
//         fitEachPage: true,
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_pdfview/flutter_pdfview.dart';

class VerticalScrollablePDFScreen extends StatefulWidget {
  @override
  _VerticalScrollablePDFScreenState createState() =>
      _VerticalScrollablePDFScreenState();
}

class _VerticalScrollablePDFScreenState
    extends State<VerticalScrollablePDFScreen> {
  String? pathPDF;

  @override
  void initState() {
    super.initState();
    generateScrollablePDF().then((path) {
      setState(() {
        pathPDF = path;
      });
    });
  }

  /// Generate a PDF with vertical content
  Future<String> generateScrollablePDF() async {
    final pdf = pw.Document();

    // Dummy content for pages
    final pageContents = List.generate(10, (index) => "Content for Section ${index + 1}");

    // Add a page with vertically stacked content
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pageContents.map((content) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20),
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                content,
                style: pw.TextStyle(fontSize: 14),
              ),
            );
          }).toList();
        },
      ),
    );

    // Save the PDF
    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/scrollable_vertical.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scrollable PDF Content")),
      body: pathPDF == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Preview Section ${i + 1}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (pathPDF != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFView(
                      filePath: pathPDF!,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageSnap: true,
                      fitEachPage: true,
                    ),
                  ),
                );
              }
            },
            child: const Text("Open Full PDF"),
          ),
        ],
      ),
    );
  }
}
