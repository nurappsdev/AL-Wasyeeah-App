import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controllers.dart';

// class WitnessPhanelData extends StatelessWidget {
//    WitnessPhanelData({super.key});
//   WitnessController witnessController = Get.put(WitnessController());
//
//   @override
//   Widget build(BuildContext context) {
//     final requestKey = Get.arguments;
//     witnessController.fetchContextsData(requestKey);
//     print("requestKey${requestKey}");
//     return Scaffold(
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class WitnessPhanelData extends StatefulWidget {
  WitnessPhanelData({super.key});

  @override
  State<WitnessPhanelData> createState() => _WitnessPhanelDataState();
}

class _WitnessPhanelDataState extends State<WitnessPhanelData> {
  WitnessController witnessController = Get.put(WitnessController());
  late final String requestKey;

  @override
  void initState() {
    super.initState();
    requestKey = Get.arguments;
    witnessController.getContextsData(requestKey);
  }
  // @override
  // Widget build(BuildContext context) {
  //   //     final requestKey = Get.arguments;
  //   // // witnessController.fetchContextsData(requestKey);
  //   //     witnessController.getContextsData(requestKey!);
  //   print("requestKey${requestKey}");
  //   return Scaffold(
  //     backgroundColor: AppColors.primaryColor,
  //     body: SingleChildScrollView(
  //       child:
  //
  //       Obx(() {
  //         if (witnessController.isLoadings.value) {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //
  //         /// 🔴 requestKey–এ data নাই
  //         if (!witnessController.hasContextsData.value) {
  //           return const Center(
  //             child: Text(
  //               "No data found for this request",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           );
  //         }
  //
  //         return Column(
  //           children: [
  //             Stack(
  //               children: [
  //                 SizedBox(
  //                   height: 260.h,
  //                   width: double.infinity,
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.only(
  //                       bottomLeft: Radius.circular(24.r),
  //                       bottomRight: Radius.circular(24.r),
  //                     ),
  //                     child: Image.asset(
  //                       AppImages.backImg,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 /// Back button
  //                 Positioned(
  //                   top: 40.h,
  //                   left: 20.w,
  //                   child: InkWell(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Icon(Icons.arrow_back_ios,
  //                         color: AppColors.whiteColor),
  //                   ),
  //                 ),
  //
  //                 /// Title
  //                 Positioned(
  //                   top: 100.h,
  //                   left: 0,
  //                   right: 0,
  //                   child: Center(
  //                     child: CustomText(
  //                       text: "Witness Panel",
  //                       fontWeight: FontWeight.w600,
  //                       fontsize: 32.sp,
  //                       color: AppColors.primaryColor,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 /// Expansion tiles
  //                 Positioned(
  //                   top: 212.h,
  //                   left: 8.w,
  //                   right: 8.w,
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                     child: Column(
  //                       children: [
  //
  //                         /// 🔹 Last Zakat Info
  //                         _buildTile(
  //                           title: "Last Zakat Info",
  //                           children: [
  //                             _infoRow(
  //                               "Zakat Amount",
  //                               witnessController.zakat['zakatAmount']?.toString() ?? 'AppLocalizations.of(context)!.n_a',
  //                             ),
  //                             _infoRow(
  //                               "Total Asset",
  //                               witnessController.zakat['totalAsset']?.toString() ?? 'AppLocalizations.of(context)!.n_a',
  //                             ),
  //                           ],
  //                         ),
  //
  //                         SizedBox(height: 16.h),
  //
  //                         /// 🔹 Property Distribution
  //                         _buildTile(
  //                           title: "Property Distribution Section",
  //                           children: witnessController.propertyResult.isEmpty
  //                               ? [_emptyText()]
  //                               : witnessController.propertyResult.map<Widget>((item) {
  //                             return Padding(
  //                               padding: const EdgeInsets.symmetric(vertical: 6),
  //                               child: CustomText(
  //                                 text: item.toString(),
  //                                 textAlign: TextAlign.start,
  //                               ),
  //                             );
  //                           }).toList(),
  //                         ),
  //
  //                         SizedBox(height: 16.h),
  //
  //                         /// 🔹 Wasiyyah Preview
  //                         _buildTile(
  //                           title: "Wasiyyah Preview",
  //                           children: witnessController.wasiyyahContent.isEmpty
  //                               ? [_emptyText()]
  //                               : witnessController.wasiyyahContent.map<Widget>((item) {
  //                             return Container(
  //                               margin: const EdgeInsets.only(bottom: 12),
  //                               padding: const EdgeInsets.all(12),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey.shade100,
  //                                 borderRadius: BorderRadius.circular(10),
  //                               ),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   CustomText(
  //                                     text: item['title'] ?? '',
  //                                     fontWeight: FontWeight.w600,
  //                                     textAlign: TextAlign.start,
  //                                   ),
  //                                   SizedBox(height: 6.h),
  //                                   CustomText(
  //                                     text: item['content'] ?? '',
  //                                     textAlign: TextAlign.start,
  //                                     maxline: 50,
  //                                   ),
  //                                 ],
  //                               ),
  //                             );
  //                           }).toList(),
  //                         ),
  //
  //                         SizedBox(height: 24.h),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       }),
  //
  //
  //       // Obx(() {
  //       //   if (witnessController.isLoadings.value) {
  //       //     return const Center(child: CircularProgressIndicator());
  //       //   }
  //       //
  //       //   /// 🔴 requestKey–এ data নাই
  //       //   if (!witnessController.hasContextsData.value) {
  //       //     return const Center(
  //       //       child: Text(
  //       //         "No data found for this request",
  //       //         style: TextStyle(color: Colors.white),
  //       //       ),
  //       //     );
  //       //   }
  //       //
  //       //   /// ✅ data আছে → show করো
  //       //   return Column(
  //       //     children: [
  //       //       Column(
  //       //         crossAxisAlignment: CrossAxisAlignment.start,
  //       //         children: [
  //       //           Text(
  //       //             'Zakat: ${witnessController.zakat['zakatAmount'] ?? 'AppLocalizations.of(context)!.n_a'}',
  //       //             style: const TextStyle(color: Colors.white),
  //       //           ),
  //       //           Text(
  //       //             'Total Asset: ${witnessController.zakat['totalAsset'] ?? 'AppLocalizations.of(context)!.n_a'}',
  //       //             style: const TextStyle(color: Colors.white),
  //       //           ),
  //       //           const Divider(color: Colors.white),
  //       //           SizedBox(height: 20.h),
  //       //
  //       //
  //       //
  //       //           Stack(
  //       //             children: [
  //       //               Image.asset(AppImages.wasyyahIcon),
  //       //               Positioned(
  //       //                   right: 20.w,
  //       //                   top: 10.h,
  //       //                   child: Image.asset(AppImages.scanImg,height: 50.h,width: 40.w,)),
  //       //             ],
  //       //           ),
  //       //
  //       //           CustomText(
  //       //             text: AppLocalizations.of(context)!.bismillahir_rahmanir_raheem,
  //       //             fontsize: 14,
  //       //           ),
  //       //           SizedBox(height: 10.h),
  //       //           Divider(color: AppColors.primaryColor, height: 14),
  //       //           SizedBox(height: 10.h),
  //       //           CustomText(
  //       //             text: "ওয়াসিয়াহ (ইচ্ছানামা)".tr,
  //       //             fontsize: 20.sp,
  //       //             fontWeight: FontWeight.w700,
  //       //           ),
  //       //           SizedBox(height: 10.h),
  //       //           Divider(color: AppColors.primaryColor, height: 14),
  //       //           SizedBox(height: 20.h),
  //       //
  //       //           ...witnessController.wasiyyahContent.map((item) => Container(
  //       //             margin: const EdgeInsets.only(bottom: 12),
  //       //             padding: const EdgeInsets.all(12),
  //       //             decoration: BoxDecoration(
  //       //               color: Colors.blueGrey[800],
  //       //               borderRadius: BorderRadius.circular(8),
  //       //             ),
  //       //             child: Column(
  //       //               crossAxisAlignment: CrossAxisAlignment.start,
  //       //               children: [
  //       //                 Text(
  //       //                   item['title'] ?? '',
  //       //                   style: const TextStyle(
  //       //                     fontWeight: FontWeight.bold,
  //       //                     color: Colors.white,
  //       //                   ),
  //       //                 ),
  //       //                 const SizedBox(height: 6),
  //       //
  //       //
  //       //                 Text(
  //       //                   item['content'] ?? '',
  //       //                   style: const TextStyle(color: Colors.white70),
  //       //                 ),
  //       //               ],
  //       //             ),
  //       //           )),
  //       //         ],
  //       //       ),
  //       //     ],
  //       //   );
  //       // })
  //
  //
  //   //     Obx(() {
  //   //       if (witnessController.isLoadings.value) {
  //   //         return const Center(child: CircularProgressIndicator());
  //   //       }
  //   // /// 🔴 requestKey–এ data নাই
  //   // if (!witnessController.hasContextsData.value) {
  //   //   return const Center(
  //   //     child: Text(
  //   //       "No data found for this request",
  //   //       style: TextStyle(color: Colors.white),
  //   //     ),
  //   //   );
  //   // }
  //   //
  //   // return Column(
  //   //           children: [
  //   //             Stack(
  //   //               children: [
  //   //                 Container(
  //   //                   height: Get.height,
  //   //                   child: Column(
  //   //                     children: [
  //   //                       ClipRRect(
  //   //                         borderRadius:  BorderRadius.only(
  //   //                           bottomLeft: Radius.circular(24.r),
  //   //                           bottomRight: Radius.circular(24.r),
  //   //                         ),
  //   //                         child: Image.asset(
  //   //                           AppImages.backImg, // your image
  //   //                           fit: BoxFit.cover,
  //   //                           height: 260.h,
  //   //                           width: double.infinity,
  //   //                         ),
  //   //                       ),
  //   //                     ],
  //   //                   ),
  //   //                 ),
  //   //
  //   //                 Positioned(
  //   //                     top: 40.h,
  //   //                     left: 30.w,
  //   //
  //   //                     child: InkWell(
  //   //                         onTap: (){
  //   //                           Navigator.pop(context);
  //   //                         },
  //   //                         child: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,))
  //   //                 ),
  //   //
  //   //                 Positioned(
  //   //                     top: 100.h,
  //   //                     left: 8.w,
  //   //                     right: 8.w,
  //   //
  //   //                     child: CustomText(text: "Witness Panel",fontWeight: FontWeight.w600,fontsize: 32.sp,color: AppColors.primaryColor,)
  //   //                 ),
  //   //
  //   //                 Positioned(
  //   //                   top: 212.h,
  //   //                   left: 8.w,
  //   //                   right: 8.w,
  //   //                   child:  Padding(
  //   //                     padding:  EdgeInsets.symmetric(horizontal:20.w,vertical: 4.h),
  //   //                     child: Column(
  //   //                       children: [
  //   //                         // First tile
  //   //                         Material(
  //   //                           borderRadius: BorderRadius.circular(16.r),
  //   //                           color: Colors.white,
  //   //                           clipBehavior: Clip.antiAlias,
  //   //                           child: ExpansionTile(
  //   //                             backgroundColor: Colors.white,
  //   //                             tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  //   //                             title:  Text(
  //   //                               "Last Zakat Info",
  //   //                               style: TextStyle(
  //   //                                 color: Color(0xFF205072),
  //   //                                 fontWeight: FontWeight.w600,
  //   //                                 fontSize: 16.sp,
  //   //                               ),
  //   //                             ),
  //   //                             children:  [
  //   //
  //   //
  //   //                             ],
  //   //                           ),
  //   //                         ),
  //   //                         SizedBox(height: 16.h),
  //   //
  //   //                         // Second tile
  //   //                         Material(
  //   //                           borderRadius: BorderRadius.circular(16.r),
  //   //                           color: Colors.white,
  //   //                           clipBehavior: Clip.antiAlias,
  //   //                           child: ExpansionTile(
  //   //                             backgroundColor: Colors.white,
  //   //                             tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  //   //                             title:  Text(
  //   //                               "Property Distribution Section",
  //   //                               style: TextStyle(
  //   //                                 color: Color(0xFF205072),
  //   //                                 fontWeight: FontWeight.w600,
  //   //                                 fontSize: 16.sp,
  //   //                               ),
  //   //                             ),
  //   //                             children:  [
  //   //                       // show property distributio section
  //   //
  //   //
  //   //
  //   //                             ],
  //   //                           ),
  //   //                         ),
  //   //                         SizedBox(height: 16.h),
  //   //
  //   //                         // Third tile
  //   //                         Material(
  //   //                           borderRadius: BorderRadius.circular(12.r),
  //   //                           color: Colors.white,
  //   //                           clipBehavior: Clip.antiAlias,
  //   //                           child: ExpansionTile(
  //   //                             backgroundColor: Colors.white,
  //   //                             tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  //   //                             title: Text(
  //   //                               "Wasiyyah Preview",
  //   //                               style: TextStyle(
  //   //                                 color: Color(0xFF205072),
  //   //                                 fontWeight: FontWeight.w600,
  //   //                                 fontSize: 16.sp,
  //   //                               ),
  //   //                             ),
  //   //                             children: [
  //   //                             // Wasiyyah Preview
  //   //
  //   //
  //   //                             ],
  //   //                           ),
  //   //                         ),
  //   //                         const SizedBox(height: 24),
  //   //                       ],
  //   //                     ),
  //   //                   ),
  //   //                 ),
  //   //
  //   //               ],
  //   //             ),
  //   //
  //   //             // Other tiles below
  //   //           ],
  //   //         );
  //   //       }),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.primaryColor,
      body: Obx(() {
        if (witnessController.isLoadings.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!witnessController.hasContextsData.value) {
          return const Center(
            child: Text(
              "No data found for this request",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              /// 🔹 HEADER SECTION
              Stack(
                children: [
                  SizedBox(
                    height: 130.h,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      child: Image.asset(
                        AppImages.backImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomText(
                        text: "Access Panel",
                        fontWeight: FontWeight.w600,
                        fontsize: 32.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// 🔹 CONTENT SECTION (IMPORTANT)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    /// Last Zakat Info
                    _buildTile(
                      title: "Last Zakat Info",
                      children: [
                        _infoRow(
                          "Zakat Amount",
                          witnessController.zakat['zakatAmount']?.toString() ??
                              'AppLocalizations.of(context)!.n_a',
                        ),
                        _infoRow(
                          "Total Asset",
                          witnessController.zakat['totalAsset']?.toString() ??
                              'AppLocalizations.of(context)!.n_a',
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// Property Distribution
                    _buildTile(
                      title: "Property Distribution Section",
                      children: witnessController.propertyResult.isEmpty
                          ? [_emptyText()]
                          : [
                              _buildPropertyPieChart(
                                  witnessController.propertyResult),
                              SizedBox(height: 16.h),
                              ...witnessController.propertyResult
                                  .map<Widget>((item) => _propertyCard(item))
                                  .toList(),
                            ],
                    ),

                    // /// Property Distribution
                    // _buildTile(
                    //   title: "Property Distribution Section",
                    //   children: witnessController.propertyResult.isEmpty
                    //       ? [_emptyText()]
                    //       : witnessController.propertyResult.map<Widget>((item) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 6),
                    //       child: CustomText(
                    //         text: item.toString(),
                    //         maxline: 100,
                    //         textAlign: TextAlign.start,
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),

                    SizedBox(height: 16.h),

                    /// Wasiyyah Preview
                    _buildTile(
                      title: "Wasiyyah Preview",
                      children: witnessController.wasiyyahContent.isEmpty
                          ? [_emptyText()]
                          : witnessController.wasiyyahContent
                              .where((e) => e['visible'] == 'Y')
                              .map<Widget>((item) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: item['title'] ?? '',
                                      fontWeight: FontWeight.w600,
                                      maxline: 100,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 6.h),
                                    CustomText(
                                      text: item['content'] ?? '',
                                      maxline: 100,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTile({
    required String title,
    required List<Widget> children,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(16.r),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        title: Text(
          title,
          style: TextStyle(
            color: const Color(0xFF205072),
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        childrenPadding: EdgeInsets.all(16.w),
        children: children,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: value,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _emptyText() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "No data available",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  //proferty distribute widget
  Widget _propertyCard(Map item) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ relative_name
          CustomText(
            text: item['relative_name'] ?? '',
            fontWeight: FontWeight.w600,
            fontsize: 16.sp,
          ),

          Divider(height: 18.h),

          _propertyRow("LAND (DECIMAL)", item['land_part']),
          _propertyRow("GOLD (Vori)", item['gold_part']),
          _propertyRow("SILVER (Vori)", item['silver_part']),
          _propertyRow("CURRENCY (TAKA)", item['currency_part']),
        ],
      ),
    );
  }

  Widget _propertyRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontsize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: value?.toString() ?? "0",
            fontsize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyPieChart(List list) {
    return SizedBox(
      height: 240.h,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: List.generate(list.length, (index) {
            final item = list[index];

            final double share =
                ((item['portion_part'] ?? 0) as num).toDouble() * 100;

            final String name = item['relative_name'] ?? '';

            return PieChartSectionData(
              value: share,
              radius: 75,
              title: "${share.toStringAsFixed(1)}%\n$name",
              titleStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.3,
              ),
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }),
        ),
      ),
    );
  }

  // Widget _buildPropertyPieChart(List list) {
  //   return SizedBox(
  //     height: 220.h,
  //     child: PieChart(
  //       PieChartData(
  //         sectionsSpace: 2,
  //         centerSpaceRadius: 40,
  //         sections: List.generate(list.length, (index) {
  //           final item = list[index];
  //
  //           /// 🔹 force double
  //           final double share =
  //               ((item['share'] ?? 0) as num).toDouble() * 100;
  //
  //           return PieChartSectionData(
  //             value: share, // ✅ double
  //             title: "${share.toStringAsFixed(1)}%",
  //             radius: 70,
  //             titleStyle: TextStyle(
  //               fontSize: 12.sp,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //             color: Colors.primaries[index % Colors.primaries.length],
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }
}
