import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class CustomTextFieldWithoutBorder extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacrter;
  final Color? filColor;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final bool? readOnly;
  final int? maxLines;
  final double contenpaddingHorizontal;
  final double contenpaddingVertical;
  final Widget? sufixicons;
  final FormFieldValidator? validator;
  final VoidCallback? onTap;
  final String? helperText;
  final AutovalidateMode? autovalidateMode;
  final Function(String value)? onChanged;

  const CustomTextFieldWithoutBorder({
    super.key,
    required this.contenpaddingHorizontal,
    required this.contenpaddingVertical,
    this.hintText,
    this.prefixIcon,
    this.readOnly = false,
    this.sufixicons,
    this.validator,
    this.maxLines,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscureCharacrter = '*',
    this.filColor,
    this.labelText,
    this.onTap,
    this.helperText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly!,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText!,
      autovalidateMode: autovalidateMode,
      obscuringCharacter: obscureCharacrter!,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style:  TextStyle(color: Colors.black, fontSize: 14.h),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: contenpaddingHorizontal.toDouble(),
            vertical: contenpaddingVertical.toDouble()),
        filled: true,
        fillColor: filColor ?? AppColors.cardColorE8F1EE,
        prefixIcon: prefixIcon,
        suffixIcon: sufixicons,
        helperText: helperText,
        prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
        errorStyle: const TextStyle(color: Colors.red),
        suffixIconColor: AppColors.primaryColor,
        prefixIconColor: AppColors.primaryColor,
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFF5C5C5C),
            fontFamily: 'OpenSans-Regular',
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
              width: 0.w
          ),
        ),
        // errorBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
        disabledBorder: _buildOutlineInputBorder(),
      ),
    );
  }

  _buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none
    );
  }
}