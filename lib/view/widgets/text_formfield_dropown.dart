
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';

class TextFormFieldTextContainerWidget extends GetxController{


  Widget textFormFieldTextContainerWidget({
    required BuildContext context,
    required double mainContainerHeight,
    required double mainContainerWidth,
    required double mainContainerLeftPadding,
    required double mainContainerRightPadding,
    required double mainContainerTopPadding,
    required double mainContainerBottomPadding,
    required Color mainContainerColor,
    required double mainContainerRadius,
    required TextEditingController controller,
    required bool textFormFieldObscureText,
    required bool textFormFieldReadOnly,
    required TextInputType textFormFieldInputType,
    required double textFormFieldLeftPadding,
    required double textFormFieldRightPadding,
    required double textFormFieldTopPadding,
    required double textFormFieldBottomPadding,
    required bool isNeedPrefixIcon,
    required String prefixImageString,
    required BoxFit prefixImageBoxFit,
    required double prefixImageLeftPadding,
    required double prefixImageRightPadding,
    required double prefixImageTopPadding,
    required double prefixImageBottomPadding,
    required String hintTextString,
    required double hintTextFontSize,
    required Color hintTextFontColor,
    required FontWeight hintTextFontWeight,
    required FontStyle hintTextFontStyle,
    required bool isNeedSuffixIcon,
    required String suffixImageString,
    required BoxFit suffixImageBoxFit,
    required double suffixImageLeftPadding,
    required double suffixImageRightPadding,
    required double suffixImageTopPadding,
    required double suffixImageBottomPadding,
    required Function() suffixImageIconOnTap,
    required Function(String value) textFormFieldOnChange,
    required Function() textFormFieldOnTab,
    required String? Function(String? value) textFormFieldValidator,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height / mainContainerHeight,
      width: MediaQuery.of(context).size.width / mainContainerWidth,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / mainContainerLeftPadding,
        right: MediaQuery.of(context).size.width / mainContainerRightPadding,
        bottom: MediaQuery.of(context).size.height / mainContainerBottomPadding,
        top: MediaQuery.of(context).size.height / mainContainerTopPadding,
      ),
      decoration: BoxDecoration(
        color: mainContainerColor,
        borderRadius: BorderRadius.circular(mainContainerRadius),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: textFormFieldObscureText,
        readOnly: textFormFieldReadOnly,
        keyboardType: textFormFieldInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / textFormFieldLeftPadding,
            right: MediaQuery.of(context).size.width / textFormFieldRightPadding,
            bottom: MediaQuery.of(context).size.height / textFormFieldBottomPadding,
            top: MediaQuery.of(context).size.height / textFormFieldTopPadding,
          ),
          prefixIcon: isNeedPrefixIcon == true ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / prefixImageLeftPadding,
              right: MediaQuery.of(context).size.width / prefixImageRightPadding,
              bottom: MediaQuery.of(context).size.height / prefixImageBottomPadding,
              top: MediaQuery.of(context).size.height / prefixImageTopPadding,
            ),
            child: Image(
              image: AssetImage(prefixImageString),
              fit: prefixImageBoxFit,
            ),
          ) : const SizedBox.shrink(),
          hintText: hintTextString,
          hintStyle: GoogleFonts.nunito(
            fontSize: hintTextFontSize,
            color: hintTextFontColor,
            fontWeight: hintTextFontWeight,
            fontStyle: hintTextFontStyle,
          ),
          suffixIcon: isNeedSuffixIcon == true ? InkWell(
            onTap: suffixImageIconOnTap,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / suffixImageLeftPadding,
                right: MediaQuery.of(context).size.width / suffixImageRightPadding,
                bottom: MediaQuery.of(context).size.height / suffixImageBottomPadding,
                top: MediaQuery.of(context).size.height / suffixImageTopPadding,
              ),
              child: Image(
                image: AssetImage(suffixImageString),
                fit: suffixImageBoxFit,
              ),
            ),
          ) : SizedBox.shrink(),
        ),
        onChanged: textFormFieldOnChange,
        onTap: textFormFieldOnTab,
        validator: textFormFieldValidator,
      ),
    );
  }



  Widget textFormFieldTextContainerWidgetWithOutFunction({
    required BuildContext context,
    required double mainContainerHeight,
    required double mainContainerWidth,
    required double mainContainerLeftPadding,
    required double mainContainerRightPadding,
    required double mainContainerTopPadding,
    required double mainContainerBottomPadding,
    required Color mainContainerColor,
    required double mainContainerRadius,
    required TextEditingController controller,
    required TextInputType textFormFieldInputType,
    required double textFormFieldLeftPadding,
    required double textFormFieldRightPadding,
    required double textFormFieldTopPadding,
    required double textFormFieldBottomPadding,
    required String prefixImageString,
    required BoxFit prefixImageBoxFit,
    required double prefixImageLeftPadding,
    required double prefixImageRightPadding,
    required double prefixImageTopPadding,
    required double prefixImageBottomPadding,
    required String hintTextString,
    required double hintTextFontSize,
    required Color hintTextFontColor,
    required FontWeight hintTextFontWeight,
    required FontStyle hintTextFontStyle,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height / mainContainerHeight,
      width: MediaQuery.of(context).size.width / mainContainerWidth,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / mainContainerLeftPadding,
        right: MediaQuery.of(context).size.width / mainContainerRightPadding,
        bottom: MediaQuery.of(context).size.height / mainContainerBottomPadding,
        top: MediaQuery.of(context).size.height / mainContainerTopPadding,
      ),
      decoration: BoxDecoration(
        color: mainContainerColor,
        borderRadius: BorderRadius.circular(mainContainerRadius),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textFormFieldInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / textFormFieldLeftPadding,
            right: MediaQuery.of(context).size.width / textFormFieldRightPadding,
            bottom: MediaQuery.of(context).size.height / textFormFieldBottomPadding,
            top: MediaQuery.of(context).size.height / textFormFieldTopPadding,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / prefixImageLeftPadding,
              right: MediaQuery.of(context).size.width / prefixImageRightPadding,
              bottom: MediaQuery.of(context).size.height / prefixImageBottomPadding,
              top: MediaQuery.of(context).size.height / prefixImageTopPadding,
            ),
            child: Image(
              image: AssetImage(prefixImageString),
              fit: prefixImageBoxFit,
            ),
          ),
          hintText: hintTextString,
          hintStyle: GoogleFonts.nunito(
            fontSize: hintTextFontSize,
            color: hintTextFontColor,
            fontWeight: hintTextFontWeight,
            fontStyle: hintTextFontStyle,
          ),
        ),
      ),
    );
  }

  Widget dropDownTextFormFieldTextContainerWidget({
    required BuildContext context,
    required double textContainerLeftPadding,
    required double textContainerRightPadding,
    required double textContainerTopPadding,
    required double textContainerBottomPadding,
    required double mainContainerHeight,
    required double mainContainerWidth,
    required double mainContainerLeftPadding,
    required double mainContainerRightPadding,
    required double mainContainerTopPadding,
    required double mainContainerBottomPadding,
    required Color mainContainerColor,
    required double mainContainerRadius,
    required TextEditingController controller,
    required bool textFormFieldObscureText,
    required bool textFormFieldReadOnly,
    required TextInputType textFormFieldInputType,
    required double textFormFieldRightPadding,
    required double textFormFieldTopPadding,
    required double textFormFieldBottomPadding,
    required String hintTextString,
    required double hintTextFontSize,
    required Color hintTextFontColor,
    required FontWeight hintTextFontWeight,
    required FontStyle hintTextFontStyle,
    required bool isNeedSuffixIcon,
    required String suffixImageString,
    required BoxFit suffixImageBoxFit,
    required double suffixImageLeftPadding,
    required double suffixImageRightPadding,
    required double suffixImageTopPadding,
    required double suffixImageBottomPadding,
    required Function() suffixImageIconOnTap,
    required Function(String value) textFormFieldOnChange,
    required Function() textFormFieldOnTab,
    required String? Function(String? value) textFormFieldValidator,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / textContainerLeftPadding,
        right: MediaQuery.of(context).size.width / textContainerRightPadding,
        top: MediaQuery.of(context).size.height / textContainerTopPadding,
        bottom: MediaQuery.of(context).size.height / textContainerBottomPadding,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / mainContainerHeight,
        width: MediaQuery.of(context).size.width / mainContainerWidth,
        // padding: EdgeInsets.only(
        //   left: MediaQuery.of(context).size.width / mainContainerLeftPadding,
        //   right: MediaQuery.of(context).size.width / mainContainerRightPadding,
        //   bottom: MediaQuery.of(context).size.height / mainContainerBottomPadding,
        //   top: MediaQuery.of(context).size.height / mainContainerTopPadding,
        // ),
        decoration: BoxDecoration(
          color: mainContainerColor,
          borderRadius: BorderRadius.circular(mainContainerRadius),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: textFormFieldObscureText,
          readOnly: textFormFieldReadOnly,
          keyboardType: textFormFieldInputType,
          showCursor: true,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 12.r),
              borderSide:BorderSide(
                  color: AppColors.primaryColor
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 12.r),
              borderSide:BorderSide(
                  color: AppColors.primaryColor
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / textFormFieldRightPadding,
              bottom: MediaQuery.of(context).size.height / textFormFieldBottomPadding,
              top: MediaQuery.of(context).size.height / textFormFieldTopPadding,
            ),
            hintText: hintTextString,
            hintStyle: GoogleFonts.poppins(
              fontSize: hintTextFontSize,
              color: hintTextFontColor,
              fontWeight: hintTextFontWeight,
              fontStyle: hintTextFontStyle,
            ),
            suffixIcon: isNeedSuffixIcon == true ? InkWell(
              onTap: suffixImageIconOnTap,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / suffixImageLeftPadding,
                  right: MediaQuery.of(context).size.width / suffixImageRightPadding,
                  bottom: MediaQuery.of(context).size.height / suffixImageBottomPadding,
                  top: MediaQuery.of(context).size.height / suffixImageTopPadding,
                ),
                child: Image(
                  color: AppColors.primaryColor,
                  image: AssetImage(suffixImageString),
                  fit: suffixImageBoxFit,
                ),
              ),
            ) : SizedBox.shrink(),
          ),
          onChanged: textFormFieldOnChange,
          onTap: textFormFieldOnTab,
          validator: textFormFieldValidator,
        ),
      ),
    );
  }


}
