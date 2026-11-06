import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        title: Text(
          AppLocalizations.of(context)!.exit_app_title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.exit_app_message,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black87,
            fontSize: 15.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              AppLocalizations.of(context)!.no,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      );
    },
  );

  if (shouldExit == true) {
    SystemNavigator.pop();
    return true;
  }
  return false;
}
