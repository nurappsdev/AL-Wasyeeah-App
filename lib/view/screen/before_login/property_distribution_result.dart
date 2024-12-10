
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

// class PropertyDistributionResultScreen extends StatelessWidget {
//    PropertyDistributionResultScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: CustomText(text: "Property Distribution Result".tr,fontsize: 18.sp,),),
//       body: Container(
//         height: Get.height,
//         width: double.infinity,
//         child: Column(
//           children: [
//         PieChart(
//         PieChartData(
//         sections: [
//         PieChartSectionData(
//           color: Colors.green,
//           value: 45,
//           title: '45%',
//           radius: 60,
//           titleStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         PieChartSectionData(
//           color: Colors.yellow,
//           value: 31,
//           title: '31%',
//           radius: 60,
//           titleStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//
//         ],
//         sectionsSpace: 2, // Space between sections
//         centerSpaceRadius: 50, // Space in the middle
//       )
//         )
//           ],
//         ),
//       ),
//     );
//   }
// }


class PropertyDistributionResultScreen extends StatelessWidget {
  const PropertyDistributionResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Property Distribution Result".tr,fontsize: 18.sp,),),
     body:  BackgroundImageContainer(
       child: SingleChildScrollView(
         child: Container(
           width: double.infinity,
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
             child: Column(
               children: [
       
                 ///==================Chart===================
                 Container(
                 height: 300.h,
                   child: PieChart(
                      PieChartData(
                        sections: showingSections(),
                        sectionsSpace: 2, // Space between sections
                        centerSpaceRadius: 40, // Space in the middle (hole of the donut)
                      ),
                    ),
                 ),
                 ///==================result===================
                 Container(
                 height: 160.h,
                 child: Column(
                   children: [
                     CustomText(text: "পুত্র ১  - ০.৪".tr,fontsize: 18.sp,color: Color(0xff9747FF),),
                     CustomText(text: "পুত্র ২  - ০.৪".tr,fontsize: 18.sp,color: Color(0xffFF7A00),),
                     CustomText(text: "কন্যা   - ০.২".tr,fontsize: 18.sp,color: Color(0xff00A851),)
                   ],
                 ),
               ),
                 ///==================bonton===================
                 Container(
                   padding: EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.purple, width: 2),
                     borderRadius: BorderRadius.circular(12),
                   ),
                   width: 350,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text(
                         'Plot 1',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.black,
                         ),
                       ),
                       SizedBox(height: 16),
                       Table(
                         columnWidths: {
                           0: FlexColumnWidth(2),
                           1: FlexColumnWidth(1),
                           2: FlexColumnWidth(1),
                           3: FlexColumnWidth(2),
                         },
                         border: TableBorder.symmetric(
                           inside: BorderSide(color: Colors.grey.shade300, width: 1),
                         ),
                         children: [
                           TableRow(
                             children: [
                               _buildTableHeader('Land (Decimal)'),
                               _buildTableHeader('Gold (Bhari)'),
                               _buildTableHeader('Silver (Bhari)'),
                               _buildTableHeader('Money (Taka)'),
                             ],
                           ),
                           TableRow(
                             children: [
                               _buildTableCell('20'),
                               _buildTableCell('0.6'),
                               _buildTableCell('8'),
                               _buildTableCell('1269842.8'),
                             ],
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 20.h,),
                 Container(
                   padding: EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.purple, width: 2),
                     borderRadius: BorderRadius.circular(12),
                   ),
                   width: 350,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text(
                         'Plot 2',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.black,
                         ),
                       ),
                       SizedBox(height: 16),
                       Table(
                         columnWidths: {
                           0: FlexColumnWidth(2),
                           1: FlexColumnWidth(1),
                           2: FlexColumnWidth(1),
                           3: FlexColumnWidth(2),
                         },
                         border: TableBorder.symmetric(
                           inside: BorderSide(color: Colors.grey.shade300, width: 1),
                         ),
                         children: [
                           TableRow(
                             children: [
                               _buildTableHeader('Land (Decimal)'),
                               _buildTableHeader('Gold (Bhari)'),
                               _buildTableHeader('Silver (Bhari)'),
                               _buildTableHeader('Money (Taka)'),
                             ],
                           ),
                           TableRow(
                             children: [
                               _buildTableCell('20'),
                               _buildTableCell('0.6'),
                               _buildTableCell('8'),
                               _buildTableCell('1269842.8'),
                             ],
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 20.h,),
       
       
               ],
             ),
           ),
         ),
       ),
     ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.blueAccent,
        value: 40,
        title: '40%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.greenAccent,
        value: 30,
        title: '30%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.redAccent,
        value: 20,
        title: '20%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orangeAccent,
        value: 10,
        title: '10%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
