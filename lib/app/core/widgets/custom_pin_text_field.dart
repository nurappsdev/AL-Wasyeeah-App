import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key, this.textEditingController});
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      autoFocus: false,
      scrollPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        textEditingController?.text = value;
      },
    );
  }
}
