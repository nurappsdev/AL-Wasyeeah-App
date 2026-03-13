import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/utils.dart';
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
          return Center(
            child: Text(
              AppLocalizations.of(context)!.no_data,
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
                        text: AppLocalizations.of(context)!.access_panel,
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
                      title: AppLocalizations.of(context)!.z_k_i,
                      children: [
                        _infoRow(
                          AppLocalizations.of(context)!.payable_zakat,
                          witnessController.zakat['zakatAmount']?.toString() ??
                              AppLocalizations.of(context)!.n_a,
                        ),
                        _infoRow(
                          AppLocalizations.of(context)!.total_assets,
                          witnessController.zakat['totalAsset']?.toString() ??
                              AppLocalizations.of(context)!.n_a,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// Property Distribution
                    _buildTile(
                      title: AppLocalizations.of(context)!
                          .property_calculation_section,
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
                      title: AppLocalizations.of(context)!.wasyyah_preview,
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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        AppLocalizations.of(context)!.no_data,
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

          _propertyRow(
              AppLocalizations.of(context)!.land_area, item['land_part']),
          _propertyRow(
              AppLocalizations.of(context)!.gram_vori, item['gold_part']),
          _propertyRow(
              AppLocalizations.of(context)!.gram_vori, item['silver_part']),
          _propertyRow(
              AppLocalizations.of(context)!.taka, item['currency_part']),
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
}
