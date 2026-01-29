//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/localization_controller.dart';


//
// class LanguageScreen extends StatelessWidget {
//   LanguageScreen({super.key});
//
//   final LocalizationController controller = Get.find<LocalizationController>(); //
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Language".tr),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.w),
//         child: Obx(
//               () => Column(
//             children: [
//               _languageTile(
//                 title: "English",
//                 value: 'en',
//               ),
//               SizedBox(height: 12.h),
//               _languageTile(
//                 title: "বাংলা",
//                 value: 'bn',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _languageTile({
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.green),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: CheckboxListTile(
//         contentPadding: EdgeInsets.zero,
//         title: Text(
//           title,
//           style: TextStyle(fontSize: 16.sp),
//         ),
//         value: controller.selectedLanguage.value == value,
//         onChanged: (_) {
//           controller.changeLanguage(value);
//         },
//         controlAffinity: ListTileControlAffinity.trailing,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/localization_controller.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LocalizationController controller =
  Get.find<LocalizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language".tr),
      ),
      body: GetBuilder<LocalizationController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _languageTile(
                  title: "English",
                  index: 0,
                  locale: const Locale('en', 'US'),
                ),
                SizedBox(height: 12.h),
                _languageTile(
                  title: "বাংলা",
                  index: 1,
                  locale: const Locale('bd', 'BD'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _languageTile({
    required String title,
    required int index,
    required Locale locale,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
        value: controller.selectedIndex == index,
        onChanged: (_) {
          controller.setSelectIndex(index);
          controller.setLanguage(locale);
        },
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
