
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PropertyDistributionScreen extends StatelessWidget {
  const PropertyDistributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Property Distribution".tr,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(text: "List of relatives".tr,fontsize: 18.sp,),
                  CustomText(text: "Skip".tr,fontsize: 18.sp,)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
