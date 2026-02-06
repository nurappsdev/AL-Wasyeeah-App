import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

class PropertyDistributionCalculationPage extends StatelessWidget {
  PropertyDistributionCalculationPage({super.key});

  final controller = Get.find<PropertyDistributionCalculationController>();
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 48,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              title.tr,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          SizedBox(height: 16),
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
          'propertyDistributionTitle'.tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20),
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
                  _sectionTitle('relativeList'),
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
                  _sectionTitle('propertyDistributionTitle'),
                  _buildPropertySection(),
                  Obx(() {
                    if (controller.propertyDistributionResult.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        _sectionTitle('calculationResults'),
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
                        'calculate'.tr,
                        style: const TextStyle(
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 250,
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
                      fontSize: 12,
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
          SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 8,
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
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _chartColors[index % _chartColors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    data.relativeName ?? 'unknown'.tr,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemBuilder: (context, index) {
        final data = controller.propertyDistributionResult[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      color: _chartColors[index % _chartColors.length],
                    ),
                    SizedBox(width: 8),
                    Text(
                      data.relativeName ?? 'unknown'.tr,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                _resultRow(
                    'sharePortion'.tr, "${(data.portionPart ?? 0) * 100}%"),
                if (data.landPart != null && data.landPart! > 0)
                  _resultRow('landPortion'.tr, "${data.landPart} Deciman"),
                if (data.goldPart != null && data.goldPart! > 0)
                  _resultRow('goldPortion'.tr,
                      "${data.goldPart} ${'gram'.tr}/${'vori'.tr}"),
                if (data.silverPart != null && data.silverPart! > 0)
                  _resultRow('silverPortion'.tr,
                      "${data.silverPart} ${'gram'.tr}/${'vori'.tr}"),
                if (data.currencyPart != null && data.currencyPart! > 0)
                  _resultRow('totalMoney'.tr, "${data.currencyPart} Taka"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
            'propertyCalculationSection'.tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPropertyField(
            label: 'landInDeciman'.tr,
            controller: controller.landController,
            hint: 'enterLandAmount'.tr,
          ),
          _buildPropertyFieldWithUnit(
            label: 'goldAmount'.tr,
            controller: controller.goldController,
            hint: 'enterGoldAmount'.tr,
            unitValue: controller.goldUnit,
          ),
          _buildPropertyFieldWithUnit(
            label: 'silverAmount'.tr,
            controller: controller.silverController,
            hint: 'enterSilverAmount'.tr,
            unitValue: controller.silverUnit,
          ),
          _buildPropertyField(
            label: 'totalMoneyInTaka'.tr,
            controller: controller.moneyController,
            hint: 'enterMoneyAmount'.tr,
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
                          items: ['gram', 'vori'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.tr),
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
                Text('count'.tr, style: TextStyle(color: Colors.grey)),
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
