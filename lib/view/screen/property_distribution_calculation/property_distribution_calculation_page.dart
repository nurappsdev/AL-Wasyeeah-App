import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';

class PropertyDistributionCalculationPage extends StatelessWidget {
  PropertyDistributionCalculationPage({super.key});

  final controller = Get.put(PropertyDistributionCalculationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property Distribution Calculation"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.filteredRelatives.length,
          itemBuilder: (context, index) {
            final rel = controller.filteredRelatives[index];
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
          },
        );
      }),
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
            if (controller.dynamicIsChecked[key] == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Count: ",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          size: 20, color: AppColors.redColor),
                      onPressed: () => controller.decrementDynamic(key),
                    ),
                    SizedBox(
                      width: 25,
                      child: Center(
                        child: Text(
                          (controller.dynamicCounts[key] ?? 0).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          size: 20, color: AppColors.primaryColor),
                      onPressed: () => controller.incrementDynamic(key),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
