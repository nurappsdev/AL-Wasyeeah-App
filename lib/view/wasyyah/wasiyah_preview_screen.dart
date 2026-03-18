import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/models.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class WasyyahPreviewScreen extends StatefulWidget {
  const WasyyahPreviewScreen({super.key});

  @override
  State<WasyyahPreviewScreen> createState() => _WasyyahPreviewScreenState();
}

class _WasyyahPreviewScreenState extends State<WasyyahPreviewScreen> {
  late final List<GetWasyyahResponseModel> waseeyaList;

  @override
  void initState() {
    super.initState();
    waseeyaList = Get.arguments as List<GetWasyyahResponseModel>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.wasyyah_preview,
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BackgroundImageContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            padding: EdgeInsets.only(bottom: 40.h),
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Image.asset(AppImages.wasyyahImg),
                  Positioned(
                    left: 20.w,
                    top: 14.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// BARCODE
                        RotatedBox(
                          quarterTurns: 1, // vertical
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: 'ALQ820',
                            width: 50,
                            height: 20,
                            drawText: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16.w,
                    top: 14.h,
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      padding: EdgeInsets.all(10),
                      color: Colors.transparent, // debug purpose
                      child: PrettyQrView.data(
                        data: AppLocalizations.of(context)!.n_a,
                        errorCorrectLevel: QrErrorCorrectLevel.H,
                      ),
                    ),
                  )
                ],
              ),

              CustomText(
                text: AppLocalizations.of(context)!.bismillahir_rahmanir_raheem,
                fontsize: 14,
              ),
              SizedBox(height: 10.h),
              Divider(color: AppColors.primaryColor, height: 14),
              SizedBox(height: 10.h),
              CustomText(
                text: AppLocalizations.of(context)!.wasiyah_will,
                fontsize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              Divider(color: AppColors.primaryColor, height: 14),
              SizedBox(height: 20.h),

              ///========== Dynamic Wasyyah List ===============
              ...waseeyaList
                  .where((item) => item.visible == "Y")
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 2,
                            //     blurRadius: 5,
                            //     offset: Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.h),
                                Center(
                                  child: CustomText(
                                    text: item.title ?? AppLocalizations.of(context)!.own_identity,
                                    fontsize: 16.sp,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(
                                    color: AppColors.primaryColor,
                                    endIndent: 2.2,
                                    thickness: 1.2,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                CustomText(
                                  fontWeight: FontWeight.w500,
                                  maxline: 100,
                                  text: item.content ?? AppLocalizations.of(context)!.no_content_available,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
