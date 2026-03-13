import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_wasyeah/main.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _languageTile(
              title: "English",
              isSelected: isEnglish,
              locale: const Locale('en'),
            ),
            SizedBox(height: 12.h),
            _languageTile(
              title: "বাংলা",
              isSelected: !isEnglish,
              locale: const Locale('bn'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageTile({
    required String title,
    required bool isSelected,
    required Locale locale,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
        value: isSelected,
        onChanged: (_) {
          WasyeeahApp.setLocale(context, locale);
        },
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
