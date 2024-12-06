
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscure;
  final Color? filColor;
  final Color? borderColor;
  final Color? hintextColor;
  final Color? textColor;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final int? maxLine;
  final double? hintextSize;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final bool isPassword;
  final bool? isEmail;
  final bool? readOnly;
  final double? borderRadio;
  final Function? onTap;
  final Function(String value)? onChange;
  const  CustomTextField(
      {super.key,
        this.contentPaddingHorizontal,
        this.contentPaddingVertical,
        this.hintText,
        this.prefixIcon,
        this.suffixIcon,
        this.maxLine,
        this.validator,
        this.hintextColor,
        this.textColor,
        this.borderColor,
        this.isEmail,
        required this.controller,
        this.keyboardType = TextInputType.text,
        this.isObscureText = false,
        this.obscure = '*',
        this.filColor,
        this.hintextSize,
        this.labelText,
        this.isPassword = false,
        this.readOnly = false, this.borderRadio,
        this.onTap,
        this.onChange
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: widget.onTap != null
          ? () {
        widget.onTap!(); // Safely call the function if it's not null
      }
          : null,
      readOnly: widget.readOnly!,
      controller: widget.controller,

      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscure!,
      maxLines: widget.maxLine ?? 1,
      // validator: widget.validator,
      validator: widget.validator ??
              (value) {
            if (widget.isEmail == null) {
              if (value!.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (widget.isPassword) {
                bool data = AppConstants.validatePassword(value);
                if (value.isEmpty) {
                  return "Please enter ${widget.hintText!.toLowerCase()}";
                } else if (data) {
                  return "Insecure password detected.";
                }
              }
            } else {
              bool data = AppConstants.emailValidate.hasMatch(value!);
              if (value.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (data) {
                return "Please check your email!";
              }
            }
            return null;
          },

      onChanged: widget.onChange,
      cursorColor: Color(0xff4A8D74),
      obscureText: widget.isPassword ? obscureText : false,
      style: TextStyle(color: widget.textColor ?? Colors.black, fontSize: widget.hintextSize ?? 16.h),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.contentPaddingHorizontal ?? 20.w,
            vertical: widget.contentPaddingVertical ?? 10.h),
        fillColor: const Color(0xffFFFFFF),
        filled: true,
        errorStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.red,fontFamily: "ComicNeue-Light"),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? GestureDetector(
          onTap: toggle,
          child: _suffixIcon(
              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
        )
            : widget.suffixIcon,
        prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintextColor ?? Colors.black54, fontSize: widget.hintextSize ?? 14.h,fontWeight: FontWeight.w400,fontFamily: "ComicNeue-Light"),
        focusedBorder: focusedBorder(),
        enabledBorder: enabledBorder(),
        errorBorder: errorBorder(),
        border: focusedBorder(),
      ),
    );
  }

  _suffixIcon(IconData icon) {
    return Padding(padding: const EdgeInsets.all(12.0), child: Icon(icon,color:AppColors.iconColor));
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular( widget.borderRadio?.r ?? 16.r),
      borderSide:BorderSide(
          color: widget.borderColor ??AppColors.primaryColor
      ),
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide:BorderSide(
          color: widget.borderColor ?? AppColors.hitTextColor000000
      ),
    );
  }
  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide: const BorderSide(
        color: Colors.red,width: 0.5,
      ),

    );
  }
}

