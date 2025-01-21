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
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class WasyyahPreviewScreen extends StatefulWidget {
  const WasyyahPreviewScreen({super.key});

  @override
  State<WasyyahPreviewScreen> createState() => _WasyyahPreviewScreenState();
}

class _WasyyahPreviewScreenState extends State<WasyyahPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: CustomText(
        text: "Wasyyah Preview",
        fontsize: 18.sp,
        fontWeight: FontWeight.w600,
    ),
        ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 20.h),
                  Image.asset(AppImages.wasyyahIcon),
                  CustomText(text: "Bismillahir Rahmanir Raheem".tr,fontsize: 14,),
                  SizedBox(height: 10.h,),
                  Divider(color: AppColors.primaryColor,height: 14,),
                  SizedBox(height: 10.h,),
                  CustomText(text: "ওয়াসিয়াহ (ইচ্ছানামা)".tr,fontsize: 20.sp,fontWeight: FontWeight.w700,),
                  SizedBox(height: 10.h,),
                  Divider(color: AppColors.primaryColor,height: 14,),
                  // SizedBox(height: 10.h,),
                  // CustomText(text: "আসসালামু আলাইকুম ওয়া রাহমাতুল্লা ইন্নালহামদালিল্লাহি রাব্বিল আ'লামীন \n ওয়াসসালাতু ওয়াসসালামু আলা রাসুলিল্লাহ \n (সাল্লাল্লাহু আলাইহিসসালাম)।",maxline: 4),
                  SizedBox(height: 20.h,),
        
                  ///====================================নিজের পরিচিতি================================
                  SizedBox(
                    height: 280.h,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10), // Rounded corners
                        //   color: Colors.white, // Background color
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                        //       spreadRadius: 2, // How much the shadow spreads
                        //       blurRadius: 5, // Softness of the shadow
                        //       offset: Offset(0, 3), // Offset in x and y (horizontal, vertical)
                        //     ),
                        //   ],
                        // ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            CustomText(text: "নিজের পরিচিতি",fontsize: 16.sp,),
                            Padding(
                              padding:  EdgeInsets.only(left: 80,right: 80),
                              child: Divider(color: AppColors.primaryColor,endIndent: 2.2,thickness: 1.2,),
                            ),
                            SizedBox(height: 6.h,),
                            CustomText(fontWeight:FontWeight.w500,text: "আমি বাড়ী নং রোড নং বাংলাদেশ- পিতাঃ তাঁর এই বলে \nস্বাক্ষ্য দিচ্ছি যে, আল্লাহ্ ছাড়া কোন ইলাহ নেই, তিনি একক \nকোন শরীক নেই। আমি আরও স্বাক্ষ্য দিচ্ছি যে মুহাম্মদ \n(সাল্লাল্লাহু আলাইহিসসালাম) তাঁর বান্দা ও রাসুল।\n আমি সম্পূর্ণ শারীরিক ও মানসিকভাবে সূস্থ অবস্থায়, \nকোন প্রকার বাহ্যিক চাপ বা প্রভাব ব্যতীত স্বপ্রনোদিত \nহয়ে এই ওয়াসিয়াহ (ইচ্ছা নাম ) প্রকাশ করছি। \nএই ওয়াসিয়াহ (ইচ্ছানামা) আমার মা, স্ত্রী, সন্তান, \nআত্মীয় স্বজন এবং প্রিয় মুসলিমদের উদেশ্যে লিখছি",textAlign: TextAlign.start,),
                            SizedBox(height: 10.h,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ///====================================নিজের পরিচিতি=========================
                  SizedBox(
                    height: 400.h,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10), // Rounded corners
                        //   color: Colors.white, // Background color
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                        //       spreadRadius: 2, // How much the shadow spreads
                        //       blurRadius: 5, // Softness of the shadow
                        //       offset: Offset(0, 3), // Offset in x and y (horizontal, vertical)
                        //     ),
                        //   ],
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 5.h,),
                              CustomText(text: "পরিবারের প্রতি দ্বীন বিষয়ক ওয়াসিয়াহ".tr,fontsize: 16.sp,),
                              Padding(
                                padding:  EdgeInsets.only(left: 20,right: 20),
                                child: Divider(color: AppColors.primaryColor,endIndent: 2.2,thickness: 1.2,),
                              ),
                              SizedBox(height: 6.h,),
                              CustomText(textAlign: TextAlign.start,fontWeight:FontWeight.w500,text: "আমার মৃত্যুর সংবাদ শোনামাত্র সকলেই আমার জন্য \nআল্লাহর কাছে ক্ষমা ও রহমত কামনা করে দোয়া করবেন। \nআমার মৃত্যুর পর মরদেহ যেন কোন প্রকার কাটাছেড়া \nবা Post mortem না করা হয়। আমি আমার পরিবারের \nসকল সদস্য, আত্মীয়স্বজন ও শুভাকাঙ্ক্ষীদের বলছি, \nআমার মৃত্যুর পর যেন অতি শোকে wail বা উচ্চস্বরে \nকান্নাকাটি না করা হয়। \nকেননা মৃত্যু একটি স্বাভাবিক ব্যপার। আল্লাহ্ বলেন : \n“প্রত্যেককে মৃত্যুর স্বাদ আস্বাদন করতে হবে। \nআমি তোমাদেরকে মন্দ ও ভাল  দ্বারা পরীক্ষা করে থাকি \nএবং আমারই কাছে তোমরা প্রত্যাবর্তিত হবে”। \n(সুরা  আনবিয়া:৩৫)।",),
                              SizedBox(height: 10.h,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  )
        
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
