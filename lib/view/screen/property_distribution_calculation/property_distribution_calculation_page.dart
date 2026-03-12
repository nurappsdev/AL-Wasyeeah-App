import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

class PropertyDistributionCalculationPage extends StatelessWidget {
  PropertyDistributionCalculationPage({super.key});

  final controller = Get.put(PropertyDistributionCalculationController());
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
              title.tr,
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Property Distribution Calculation".tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp),
        ),
        backgroundColor: AppColors.whiteColor,
        // foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.status.value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: [
                  _sectionTitle("Relative List".tr),
                  ...controller.filteredRelatives.map((rel) {
                    final relativeName = rel.relative!;
                    return Obx(() {
                      return Column(
                        children: [
                          _buildRelativeTile(relativeName),
                          if ((relativeName == "Deceased Son" ||
                                  relativeName == "Deceased Daughter") &&
                              controller.isChecked[relativeName] == true)
                            ..._buildDynamicTiles(relativeName),
                          const Divider(),
                        ],
                      );
                    });
                  }).toList(),
                  _sectionTitle("Property Distribution Calculation".tr),
                  _buildPropertySection(),
                  Obx(() {
                    if (controller.propertyDistributionResult.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        _sectionTitle("Calculation Results".tr),
                        _buildPieChartSection(),
                        _buildResultCards(),
                      ],
                    );
                  }),
                ],
              );
            }),
          ),
          Obx(() {
            if (!controller.isCalculateVisible.value) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: controller.isCalculateLoading.value
                    ? null
                    : () => controller.submitCalculation(),
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
                        "Calculate".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                sections: controller.propertyDistributionResult
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final percentage = (data.portionPart ?? 0) * 100;
                  return PieChartSectionData(
                    color: _chartColors[index % _chartColors.length],
                    value: percentage,
                    title: '${percentage.toStringAsFixed(1)}%',
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
            children: controller.propertyDistributionResult
                .asMap()
                .entries
                .map((entry) {
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
                    data.relativeName ?? "Unknown",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                      data.relativeName ?? "Unknown",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                _resultRow(
                    "Share Portion".tr, "${(data.portionPart ?? 0) * 100}%"),
                if (data.landPart != null && data.landPart! > 0)
                  _resultRow("Land Portion".tr, "${data.landPart} Decimal".tr),
                if (data.goldPart != null && data.goldPart! > 0)
                  _resultRow(
                      "Gold Portion".tr, "${data.goldPart} GRAM/VORI".tr),
                if (data.silverPart != null && data.silverPart! > 0)
                  _resultRow(
                      "Silver Portion".tr, "${data.silverPart} GRAM/VORI".tr),
                if (data.currencyPart != null && data.currencyPart! > 0)
                  _resultRow("Total Money".tr, "${data.currencyPart} Taka".tr),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          Text(value,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
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
            "Property Calculation Section".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPropertyField(
            label: "Land in Deciman".tr,
            controller: controller.landController,
            hint: "Enter land amount".tr,
          ),
          _buildPropertyFieldWithUnit(
            label: "Gold amount".tr,
            controller: controller.goldController,
            hint: "Enter gold amount".tr,
            unitValue: controller.goldUnit,
          ),
          _buildPropertyFieldWithUnit(
            label: "Silver amount".tr,
            controller: controller.silverController,
            hint: "Enter silver amount".tr,
            unitValue: controller.silverUnit,
          ),
          _buildPropertyField(
            label: "Total Money in Taka".tr,
            controller: controller.moneyController,
            hint: "Enter money amount".tr,
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          items: ["Gram", "Vori"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelativeTile(String relativeName) {
    return Column(
      children: [
        CheckboxListTile(
          activeColor: AppColors.primaryColor,
          title: Text(
            relativeName,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          value: controller.isChecked[relativeName] ?? false,
          onChanged: (val) => controller.toggleCheck(relativeName, val),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (controller.isChecked[relativeName] == true &&
            relativeName != "Husband" &&
            relativeName != "Father")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Count: ", style: TextStyle(color: Colors.grey)),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: AppColors.redColor),
                  onPressed: () => controller.decrement(relativeName),
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      controller.counts[relativeName].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.primaryColor),
                  onPressed: () => controller.increment(relativeName),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _buildDynamicTiles(String relativeName) {
    int count = controller.counts[relativeName] ?? 0;
    List<Widget> tiles = [];
    String base = relativeName == "Deceased Son" ? "Son" : "Daughter";

    for (int i = 1; i <= count; i++) {
      // Show for up to a reasonable number, or as many as the count indicates.
      // User said "if select 1 or 2 then show like...",
      // usually these are finite.
      String ordinal = controller.getOrdinal(i);
      String sonKey = "Deceased $ordinal $base's Son";
      String daughterKey = "Deceased $ordinal $base's Daughter";

      tiles.add(_buildDynamicTile(sonKey, padding: 40));
      tiles.add(_buildDynamicTile(daughterKey, padding: 40));
    }
    return tiles;
  }

  Widget _buildDynamicTile(String key, {double padding = 0}) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Column(
          children: [
            CheckboxListTile(
              activeColor: AppColors.primaryColor,
              title: Text(
                key,
                style:
                    const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
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
