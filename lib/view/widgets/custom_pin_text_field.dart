
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/utils.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key,this.textEditingController});
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
      backgroundColor: Colors.transparent,
      cursorColor: AppColors.primaryColor,
      controller: textEditingController,
      textStyle:  TextStyle(color: AppColors.textColor4E4E4E, fontSize: 16.sp, fontFamily:"ComicNeue-Light",fontWeight: FontWeight.w400),
      autoFocus: false,
      appContext: context,
      scrollPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      length: 5,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(6.r),
        fieldHeight: 80.h,
        fieldWidth: 60.h,
        activeColor: AppColors.secondaryPrimaryColor,
        inactiveColor: Color(0xffE8F1EE),
        selectedColor: AppColors.primaryColor,
        activeFillColor: AppColors.primaryColor.withOpacity(0.1),
        inactiveFillColor: AppColors.primaryColor.withOpacity(0.1),
        selectedFillColor: AppColors.primaryColor.withOpacity(0.1),
      ),
      enableActiveFill: true,
      obscureText: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
    );
  }
}