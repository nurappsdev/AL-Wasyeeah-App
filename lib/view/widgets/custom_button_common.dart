import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'widgets.dart';

class CustomButtonCommon extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool loading;

  CustomButtonCommon({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? () {} : onpress,
      child: Container(
        width: width ?? 355,
        height: height ?? 48,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? AppColors.primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : CustomText(
                    text: title,
                    fontsize: fontSize ?? 20,
                    color: titlecolor ?? Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
          ],
        ),
      ),
    );
  }
}
