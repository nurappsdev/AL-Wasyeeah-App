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
//import '../../../helpers/helpers.dart';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/app_routes.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class WasyyahPreviewScreen extends StatefulWidget {
  const WasyyahPreviewScreen({super.key});

  @override
  State<WasyyahPreviewScreen> createState() => _WasyyahPreviewScreenState();
}

class _WasyyahPreviewScreenState extends State<WasyyahPreviewScreen> {
  late final List<GetWasyyahResponseModel> waseeyaList;

  @override
  void initState() {
    super.initState();
    waseeyaList = Get.arguments as List<GetWasyyahResponseModel>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Wasyyah Preview",
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BackgroundImageContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            padding: EdgeInsets.only(bottom: 40.h),
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Image.asset(AppImages.wasyyahIcon),
                  Positioned(
                     right: 20.w,
                      top: 10.h,
                      child: Image.asset(AppImages.scanImg,height: 50.h,width: 40.w,)),
                ],
              ),

              CustomText(
                text: "Bismillahir Rahmanir Raheem".tr,
                fontsize: 14,
              ),
              SizedBox(height: 10.h),
              Divider(color: AppColors.primaryColor, height: 14),
              SizedBox(height: 10.h),
              CustomText(
                text: "ওয়াসিয়াহ (ইচ্ছানামা)".tr,
                fontsize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              Divider(color: AppColors.primaryColor, height: 14),
              SizedBox(height: 20.h),

              ///========== Dynamic Wasyyah List ===============
              ...waseeyaList
                  .where((item) => item.visible == "Y")
                  .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 2,
                    //     blurRadius: 5,
                    //     offset: Offset(0, 3),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Center(
                          child: CustomText(
                            text: item.title ?? "নিজের পরিচিতি",
                            fontsize: 16.sp,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                            color: AppColors.primaryColor,
                            endIndent: 2.2,
                            thickness: 1.2,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        CustomText(
                          fontWeight: FontWeight.w500,
                          maxline: 100,
                          text: item.content ?? "No content available.",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ))
                  .toList(),

            ],
          ),
        ),
      ),
    );
  }
}
