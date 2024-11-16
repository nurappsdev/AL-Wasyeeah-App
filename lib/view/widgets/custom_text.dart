
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomText extends StatelessWidget {

  CustomText(
      {super.key,
        this.maxline,
        this.textOverflow,
        this.fontName,
        this.textAlign = TextAlign.center,
        this.left = 0,
        this.right = 0,
        this.top = 0,
        this.bottom = 0,
        this.fontsize,
        this.textHeight,
        this.fontWeight = FontWeight.w400,
        this.color,
        this.text = ""});

  final double left;
  final TextOverflow? textOverflow;
  final double right;
  final double top;
  final double bottom;
  final double? fontsize;
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final TextAlign textAlign;
  final int? maxline;
  final String? fontName;
  final double? textHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: left, right: right, top: top, bottom: bottom),
      child: Text(
        textAlign: textAlign,
        text,
        maxLines: maxline,
        overflow: textOverflow??TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontsize ?? 14.h,
            fontFamily:fontName?? "Poppins-Regular",
            fontWeight:fontWeight == null ? FontWeight.w400 : fontWeight ,
            color: color ?? AppColors.textColor4E4E4E
        ),
      ),
    );
  }
}