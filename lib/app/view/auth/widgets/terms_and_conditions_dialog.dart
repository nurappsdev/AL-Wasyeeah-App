import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  final VoidCallback? onAccept;

  const TermsAndConditionsDialog({super.key, this.onAccept});

  static Future<void> show(BuildContext context, {VoidCallback? onAccept}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TermsAndConditionsDialog(onAccept: onAccept),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 0.8.sh,
          maxWidth: 450.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      loc.terms_and_conditions,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(loc.terms_general_title),
                      _buildParagraph(loc.terms_general_desc),
                      _buildBulletPoint(loc.terms_general_bullet_1),
                      _buildBulletPoint(loc.terms_general_bullet_2),
                      _buildBulletPoint(loc.terms_general_bullet_3),
                      _buildBulletPoint(loc.terms_general_bullet_4),
                      _buildBulletPoint(loc.terms_general_bullet_5),
                      _buildBulletPoint(loc.terms_general_bullet_6),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_eligibility_title),
                      _buildParagraph(loc.terms_eligibility_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_account_registration_title),
                      _buildParagraph(loc.terms_account_registration_desc),
                      _buildBulletPoint(loc.terms_account_registration_bullet_1),
                      _buildBulletPoint(loc.terms_account_registration_bullet_2),
                      _buildBulletPoint(loc.terms_account_registration_bullet_3),
                      _buildBulletPoint(loc.terms_account_registration_bullet_4),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_platform_use_title),
                      _buildParagraph(loc.terms_platform_use_desc),
                      _buildBulletPoint(loc.terms_platform_use_bullet_1),
                      _buildBulletPoint(loc.terms_platform_use_bullet_2),
                      _buildBulletPoint(loc.terms_platform_use_bullet_3),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_zakat_calculation_title),
                      _buildParagraph(loc.terms_zakat_calculation_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_payments_donations_title),
                      _buildParagraph(loc.terms_payments_donations_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_intellectual_property_title),
                      _buildParagraph(loc.terms_intellectual_property_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_limitation_liability_title),
                      _buildParagraph(loc.terms_limitation_liability_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_termination_title),
                      _buildParagraph(loc.terms_termination_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_governing_law_title),
                      _buildParagraph(loc.terms_governing_law_desc),

                      SizedBox(height: 14.h),
                      _buildSectionHeader(loc.terms_modifications_title),
                      _buildParagraph(loc.terms_modifications_desc),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),

            // Footer Actions
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0D000000),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryColor),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        loc.cancel,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (onAccept != null) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onAccept?.call();
                        },
                        child: Text(
                          loc.i_agree,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: AppColors.textColor4E4E4E,
          fontSize: 12.5.sp,
          height: 1.45,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: AppColors.textColor4E4E4E,
                fontSize: 12.sp,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
