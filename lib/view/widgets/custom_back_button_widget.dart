import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 8.0.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0.h),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap ?? () => Get.back(),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 16.sp, // icon scales automatically
              color: iconColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
