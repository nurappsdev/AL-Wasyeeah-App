import 'dart:developer';
import 'package:al_wasyeah/app/view/widgets/custom_app_bar.dart';

import 'package:al_wasyeah/core/services/helpers.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PropertyDistributionCalculationPage extends GetView<PropertyDistributionCalculationController> {
  PropertyDistributionCalculationPage({super.key});
  final List<dynamic> _dummyResults = List.generate(
    5,
    (index) => {
      "relativeName": "Brother (${index + 1})",
      "portionPart": 0.2,
      "landPart": 10.5,
      "goldPart": 5.2,
      "silverPart": 3.1,
      "currencyPart": 50000,
    },
  );

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Container(
            height: 48.h,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(8.h),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 22.sp),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.property_distribution_calculation,
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.obx(
              (state) {
                return ListView(
                  children: [
                    _sectionTitle(AppLocalizations.of(context)!.relative_list),
                    ...controller.filteredRelatives.map((rel) {
                      final relativeId = rel.encrypted!;
                      return Obx(() {
                        return Column(
                          children: [
                            _buildRelativeTile(relativeId),
                            if ((relativeId == PropertyDistributionCalculationController.deceasedSonId || relativeId == PropertyDistributionCalculationController.deceasedDaughterId) &&
                                controller.isChecked[relativeId] == true)
                              ..._buildDynamicTiles(relativeId),
                            const Divider(),
                          ],
                        );
                      });
                    }).toList(),
                    _sectionTitle(AppLocalizations.of(context)!.property_distribution_calculation),
                    _buildPropertySection(),
                    Obx(() {
                      if (controller.propertyDistributionResult.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          _sectionTitle(AppLocalizations.of(context)!.calculation_results),
                          if (!controller.isPublic.value)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,

                                    // minimumSize: const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  onPressed: () => controller.savePropertyDistributionCalculationResult(),
                                  child: Text(
                                    AppLocalizations.of(context)!.save,
                                    style: TextStyle(color: Colors.white, fontSize: 22.sp),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    // minimumSize: const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => controller.downloadPropertyDistributionCalculationResult(),
                                  child: Text(
                                    AppLocalizations.of(context)!.download,
                                    style: TextStyle(color: Colors.white, fontSize: 22.sp),
                                  ),
                                ),
                              ],
                            ),
                          _buildPieChartSection(),
                          _buildResultCards(),
                        ],
                      );
                    }),
                  ],
                );
              },
              onLoading: Skeletonizer(
                enabled: true,
                child: ListView(
                  children: [
                    _sectionTitle("Relative List"),

                    // Dummy Relative Tiles
                    ...List.generate(5, (index) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            value: false,
                            onChanged: null,
                            title: Text("Relative ${index + 1}"),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const Divider(),
                        ],
                      );
                    }),

                    _sectionTitle("Property Distribution Calculation"),

                    // Dummy Property Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildPropertyField(
                            label: "Land in Decimal",
                            controller: TextEditingController(text: "100"),
                            hint: "",
                          ),
                          _buildPropertyFieldWithUnit(
                            label: "Gold Amount",
                            controller: TextEditingController(text: "50"),
                            hint: "",
                            unitValue: "gram".obs,
                          ),
                          _buildPropertyFieldWithUnit(
                            label: "Silver Amount",
                            controller: TextEditingController(text: "30"),
                            hint: "",
                            unitValue: "gram".obs,
                          ),
                          _buildPropertyField(
                            label: "Total Money",
                            controller: TextEditingController(text: "100000"),
                            hint: "",
                          ),
                        ],
                      ),
                    ),

                    _sectionTitle("Calculation Results"),

                    // Dummy Pie Chart Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250.h,
                            child: PieChart(
                              PieChartData(
                                sections: _dummyResults.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final data = entry.value;
                                  final percentage = (data["portionPart"]) * 100;

                                  return PieChartSectionData(
                                    color: _chartColors[index % _chartColors.length],
                                    value: percentage,
                                    title: '${percentage}%',
                                    radius: 60,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dummy Result Cards
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dummyResults.length,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      itemBuilder: (context, index) {
                        final data = _dummyResults[index];

                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.only(bottom: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 24.h,
                                      color: _chartColors[index % _chartColors.length],
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      data["relativeName"],
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                _resultRow("Share Portion", "${(data["portionPart"] * 100)}%"),
                                _resultRow("Land Portion", "${data["landPart"]} decimal"),
                                _resultRow("Gold Portion", "${data["goldPart"]} gram"),
                                _resultRow("Silver Portion", "${data["silverPart"]} gram"),
                                _resultRow("Total Money", "${data["currencyPart"]} taka"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              onError: (error) => ErrorWidget(Exception(error)),
            ),
          ),
          Obx(() {
            if (!controller.isCalculateVisible.value) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: controller.isCalculateLoading.value ? null : () => controller.submitCalculation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: controller.isCalculateLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.calculate,
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }

  final List<Color> _chartColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  Widget _buildPieChartSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        children: [
          SizedBox(
            height: 250.h,
            child: PieChart(
              PieChartData(
                sections: controller.propertyDistributionResult.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final percentage = (data.portionPart ?? 0) * 100;
                  return PieChartSectionData(
                    color: _chartColors[index % _chartColors.length],
                    value: percentage,
                    title: '${percentage.toLocal()}%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: controller.propertyDistributionResult.asMap().entries.map((entry) {
              final index = entry.key;
              final data = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: _chartColors[index % _chartColors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _getRelativeName(data.relativeName),
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getRelativeName(String? name) {
    if (name == null) {
      return AppLocalizations.of(Get.context!)!.n_a;
    }

    final locale = Get.locale?.languageCode ?? 'en';

    final match = RegExp(r'\((\d+)\)').firstMatch(name);

    if (match != null) {
      final numberStr = match.group(1); // "1"
      final number = int.tryParse(numberStr ?? '');

      if (number != null) {
        final formattedNumber = NumberFormat.decimalPattern(locale).format(number);

        // Replace (1) → (formattedNumber)
        return name.replaceFirst(
          match.group(0)!, // "(1)"
          '($formattedNumber)',
        );
      }
    }

    return name;
  }

  Widget _buildResultCards() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.propertyDistributionResult.length,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemBuilder: (context, index) {
        final data = controller.propertyDistributionResult[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 24.h,
                      color: _chartColors[index % _chartColors.length],
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _getRelativeName(data.relativeName),
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                _resultRow(AppLocalizations.of(Get.context!)!.share_portion, "${((data.portionPart ?? 0) * 100).toLocal()}%"),
                if (data.landPart != null && data.landPart! > 0) _resultRow(AppLocalizations.of(Get.context!)!.land_portion, "${data.landPart.toLocal()} ${AppLocalizations.of(Get.context!)!.decimal}"),
                if (data.goldPart != null && data.goldPart! > 0) _resultRow(AppLocalizations.of(Get.context!)!.gold_portion, "${data.goldPart.toLocal()} ${AppLocalizations.of(Get.context!)!.gram_vori}"),
                if (data.silverPart != null && data.silverPart! > 0) _resultRow(AppLocalizations.of(Get.context!)!.silver_portion, "${data.silverPart.toLocal()} ${AppLocalizations.of(Get.context!)!.gram_vori}"),
                if (data.currencyPart != null && data.currencyPart! > 0) _resultRow(AppLocalizations.of(Get.context!)!.total_money, "${data.currencyPart.toLocal()} ${AppLocalizations.of(Get.context!)!.taka}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultRow(String label, String value) {
    log("Variable Type: ${value.runtimeType}");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPropertySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(Get.context!)!.property_calculation_section,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPropertyField(
            label: AppLocalizations.of(Get.context!)!.land_in_decimal,
            controller: controller.landController,
            hint: AppLocalizations.of(Get.context!)!.enter_land_amount,
          ),
          _buildPropertyFieldWithUnit(
            label: AppLocalizations.of(Get.context!)!.gold_amount,
            controller: controller.goldController,
            hint: AppLocalizations.of(Get.context!)!.enter_gold_amount,
            unitValue: controller.goldUnit,
          ),
          _buildPropertyFieldWithUnit(
            label: AppLocalizations.of(Get.context!)!.silver_amount,
            controller: controller.silverController,
            hint: AppLocalizations.of(Get.context!)!.enter_silver_amount,
            unitValue: controller.silverUnit,
          ),
          _buildPropertyField(
            label: AppLocalizations.of(Get.context!)!.total_money_in_taka,
            controller: controller.moneyController,
            hint: AppLocalizations.of(Get.context!)!.enter_money_amount,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyFieldWithUnit({
    required String label,
    required TextEditingController controller,
    required String hint,
    required RxString unitValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: unitValue.value,
                          isExpanded: true,
                          items: [
                            {'value': 'gram', 'label': AppLocalizations.of(Get.context!)!.gram},
                            {'value': 'vori', 'label': AppLocalizations.of(Get.context!)!.vori}
                          ].map((Map<String, String> item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text(item['label']!),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              unitValue.value = newValue;
                            }
                          },
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelativeTile(String relativeId) {
    return Column(
      children: [
        CheckboxListTile(
          activeColor: AppColors.primaryColor,
          title: Text(
            controller.allRelatives.firstWhere((element) => element.encrypted == relativeId).relative ?? AppLocalizations.of(Get.context!)!.n_a,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          value: controller.isChecked[relativeId] ?? false,
          onChanged: (val) => controller.toggleCheck(relativeId, val),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (controller.isChecked[relativeId] == true &&
            relativeId != PropertyDistributionCalculationController.husbandId &&
            relativeId != PropertyDistributionCalculationController.wifeId &&
            relativeId != PropertyDistributionCalculationController.fatherId &&
            relativeId != PropertyDistributionCalculationController.motherId &&
            relativeId != PropertyDistributionCalculationController.grandfatherId &&
            relativeId != PropertyDistributionCalculationController.deceasedSonsSonId &&
            relativeId != PropertyDistributionCalculationController.deceasedSonsDaughterId)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${AppLocalizations.of(Get.context!)!.count}: ", style: TextStyle(color: Colors.grey)),
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: AppColors.redColor),
                  onPressed: () => controller.decrement(relativeId),
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      controller.counts[relativeId].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: AppColors.primaryColor),
                  onPressed: () => controller.increment(relativeId),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _buildDynamicTiles(String relativeId) {
    int count = controller.counts[relativeId] ?? 0;
    List<Widget> tiles = [];
    String base = relativeId == PropertyDistributionCalculationController.deceasedSonId ? PropertyDistributionCalculationController.sonId : PropertyDistributionCalculationController.daughterId;

    for (int i = 1; i <= count; i++) {
      String ordinal = controller.getOrdinal(i);

      // Stable keys for state management
      String sonKey = "deceased_${relativeId}_${PropertyDistributionCalculationController.sonId}_$i";
      String daughterKey = "deceased_${relativeId}_${PropertyDistributionCalculationController.daughterId}_$i";

      // Localized labels for display
      String sonLabel =
          "${AppLocalizations.of(Get.context!)!.deceased} $ordinal ${controller.allRelatives.firstWhere((element) => element.encrypted == base).relative} ${AppLocalizations.of(Get.context!)!.s_suffix} ${AppLocalizations.of(Get.context!)!.son}";
      String daughterLabel =
          "${AppLocalizations.of(Get.context!)!.deceased} $ordinal ${controller.allRelatives.firstWhere((element) => element.encrypted == base).relative} ${AppLocalizations.of(Get.context!)!.s_suffix} ${AppLocalizations.of(Get.context!)!.daughter}";

      tiles.add(_buildDynamicTile(sonKey, sonLabel, padding: 40));
      tiles.add(_buildDynamicTile(daughterKey, daughterLabel, padding: 40));
    }
    return tiles;
  }

  Widget _buildDynamicTile(String key, String label, {double padding = 0}) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Column(
          children: [
            CheckboxListTile(
              activeColor: AppColors.primaryColor,
              title: Text(
                label,
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              value: controller.dynamicIsChecked[key] ?? false,
              onChanged: (val) => controller.toggleDynamicCheck(key, val),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      );
    });
  }
}
