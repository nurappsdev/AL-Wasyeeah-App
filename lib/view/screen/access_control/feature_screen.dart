

import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

// class _FeatureScreenState extends State<FeatureScreen> {
//   final List<String> items = [
//     "Zakat Info",
//     "Asset Calculation Info",
//     "Wasiyyah Preview",
//   ];
//
//   List<bool> isChecked = [];
//
//   @override
//   void initState() {
//     super.initState();
//     isChecked = List.filled(items.length, false);
//   }
//   NomineeController nomineeController = Get.put(NomineeController());
//   @override
//   Widget build(BuildContext context) {
//     final args = Get.arguments;
//     final requestKey = args["requestKey"];
//     print("requestKey ${requestKey}");
//     nomineeController.getAccessFeatureData();
//     nomineeController.getSelectFeatureData(requestKey: requestKey);
//
//     return Scaffold(
//       appBar: AppBar(title: CustomText(text: "Access Feature",),),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//
//             // Save Button
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               onPressed: () {
//                 print("Save clicked");
//                 print(isChecked);
//               },
//               child: const Text(
//                 "Save",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // ListView Builder
//             Obx(()=>
//                Expanded(
//                 child: ListView.builder(
//                   itemCount: nomineeController.accessControllResponseModel.length,
//                   itemBuilder: (context, index) {
//                     var AccessFeatureList =  nomineeController.accessControllResponseModel[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 18.0),
//                       child: Row(
//                         children: [
//                           // Custom Green Border Checkbox
//                           Container(
//                             height: 22,
//                             width: 22,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.green, width: 2),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Checkbox(
//                               value: isChecked[index],
//                               activeColor: Colors.green,
//                               checkColor: Colors.white,
//                               onChanged: (value) {
//                                 setState(() {
//
//                                   isChecked[index] = value ?? false;
//                                 });
//                               },
//                               side: const BorderSide(color: Colors.transparent),
//                               materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//
//                           // Text Item
//                           Text(
//                             AccessFeatureList.name ?? "N/A",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h,),
//             CustomButtonCommon(title: "Save", onpress: (){},color: AppColors.primaryColor,),
//             SizedBox(height: 40.h,),
//           ],
//         ),
//       ),
//     );
//   }
// }




class _FeatureScreenState extends State<FeatureScreen> {
  List<bool> isChecked = [];

  NomineeController nomineeController = Get.put(NomineeController());

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    final requestKey = args["requestKey"];

    // Load data only once
    loadData(requestKey);
  }

  Future<void> loadData(requestKey) async {
    await nomineeController.getAccessFeatureData();
    await nomineeController.getSelectFeatureData(requestKey: requestKey);

    // Prepare isChecked list based on matching id and key
    isChecked = nomineeController.getAccessFeatureModel.map((item) {
      return nomineeController.selectFeatureModel
          .any((selected) => selected.key == item.id);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Access Feature")),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30.h,),

            Obx(() {
              final accessList = nomineeController.getAccessFeatureModel;

              // still loading data
              if (accessList.isEmpty || isChecked.length != accessList.length) {
                return const Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: accessList.length,
                    itemBuilder: (context, index) {
                      final item = accessList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Checkbox(
                                value: isChecked[index],
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                onChanged: (value) {
                                  setState(() => isChecked[index] = value!);
                                },
                                side: const BorderSide(color: Colors.transparent),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              item.contextName ?? "N/A",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),

            SizedBox(height: 30.h,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                print("Save clicked");
                print(isChecked);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),

    );
  }
}




