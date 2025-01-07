import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class PropertyDistributionScreen2 extends StatefulWidget {
//   @override
//   _PropertyDistributionScreen2State createState() => _PropertyDistributionScreen2State();
// }
//
// class _PropertyDistributionScreen2State extends State<PropertyDistributionScreen2> {
//   // Checkbox এর স্টেট ম্যানেজমেন্টের জন্য ভ্যারিয়েবল
//   bool isCheckbox1Checked = false;
//   bool isCheckbox2Checked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkbox এবং TextField'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isCheckbox1Checked,
//                       onChanged: (value) {
//                         setState(() {
//                           isCheckbox1Checked = value ?? false;
//                         });
//                       },
//                     ),
//                     const Text("পুত্র"),
//                   ],
//                 ),
//                 SizedBox(width: 10.w,),
//                 // যদি Checkbox checked থাকে, তাহলে TextField দেখাবে
//                 isCheckbox1Checked
//                     ? Expanded(
//                   child: CustomTextField(
//                     controller: TextEditingController(),
//                     hintText: "পুত্র এর জন্য ইনপুট দিন",
//                   ),
//                 )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//
//
//              SizedBox(height: 4.h),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Controller Class for State Management


class PropertyController extends GetxController {
  var isCheckbox1Checked = false.obs;
}

class PropertyDistributionScreen2 extends StatelessWidget {
  final PropertyController controller = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox এবং TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Row(
                  children: [
                    Checkbox(
                      value: controller.isCheckbox1Checked.value,
                      onChanged: (value) {
                        controller.isCheckbox1Checked.value = value ?? false;
                      },
                    ),
                    const Text("পুত্র"),
                  ],
                )),
                const SizedBox(width: 10),
                Obx(() => controller.isCheckbox1Checked.value
                    ? Expanded(
                  child: CustomTextField(
                    controller: TextEditingController(),
                    hintText: "পুত্র এর জন্য ইনপুট দিন",
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Row(
                  children: [
                    Checkbox(
                      value: controller.isCheckbox1Checked.value,
                      onChanged: (value) {
                        controller.isCheckbox1Checked.value = value ?? false;
                      },
                    ),
                    const Text("পুত্র"),
                  ],
                )),
                const SizedBox(width: 10),
                Obx(() => controller.isCheckbox1Checked.value
                    ? Expanded(
                  child: CustomTextField(
                    controller: TextEditingController(),
                    hintText: "পুত্র এর জন্য ইনপুট দিন",
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Row(
                  children: [
                    Checkbox(
                      value: controller.isCheckbox1Checked.value,
                      onChanged: (value) {
                        controller.isCheckbox1Checked.value = value ?? false;
                      },
                    ),
                    const Text("পুত্র"),
                  ],
                )),
                const SizedBox(width: 10),
                Obx(() => controller.isCheckbox1Checked.value
                    ? Expanded(
                  child: CustomTextField(
                    controller: TextEditingController(),
                    hintText: "পুত্র এর জন্য ইনপুট দিন",
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

