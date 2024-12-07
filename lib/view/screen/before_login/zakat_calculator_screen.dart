import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ZakatCalculatorScreen extends StatelessWidget {
   ZakatCalculatorScreen({super.key});
  final GlobalKey<FormState> _forProKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Calculate Your Zakat Easily".tr,fontsize: 18.sp,),),
    body: BackgroundImageContainer(
    child: Container(
    width: double.infinity,
      height: Get.height,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
        child: SingleChildScrollView(
          child: Form(
            key: _forProKey,
            child: Column(
              children: [
                 SizedBox(height: 12.h,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: "Zakat Calculator".tr,fontsize: 18.sp,),
                ElevatedButton(onPressed: (){
                  Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);
                },child:  CustomText(text: "Skip".tr,fontsize: 18.sp,))

              ],
            ),
            SizedBox(height: 12.h,),
              ],
            )
          ),
        ),
      ),
    ),
    ),
    );

  }
}
