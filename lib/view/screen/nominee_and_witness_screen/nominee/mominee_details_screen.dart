import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class NomineeDetailsScreen extends StatelessWidget {
  NomineeDetailsScreen({super.key});
  final NomineetedResponseModel user = Get.arguments as NomineetedResponseModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.nominee_profile_details,
          fontsize: 18.sp,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://via.placeholder.com/150"),
                              radius: 30,
                            ),
                            title: Text(
                              "${user.name}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.4), // Shadow color with opacity
                          blurRadius: 10.0, // Softness of the shadow
                          offset:
                              Offset(0.5, 1), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, //
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: CustomText(
                              text: AppLocalizations.of(context)!
                                  .personal_details,
                              fontsize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10.h),

                          /// Relation Row
                          _buildRow("Relation:",
                              "${user.relation ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Mobile Row
                          _buildRow("Mobile:",
                              "${user.mobile ?? "AppLocalizations.of(context)!.n_a"}"),
                          _buildRow("Profession:",
                              "${user.profession ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Email Row
                          _buildRow("Email:",
                              "${user.email ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Marital Status Row
                          _buildRow("Marital Status:",
                              "${user.maritalStatus ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Mother's Name Row
                          _buildRow("Mother’s Name:",
                              "${user.motherName ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Father's Name Row
                          _buildRow("Father’s Name:",
                              "${user.fatherName ?? "AppLocalizations.of(context)!.n_a"}"),

                          /// Buttons
                          SizedBox(height: 30.h),
                          CustomButtonCommon(
                              title: "Access Panel",
                              onpress: () {
                                Get.toNamed(AppRoutes.witnessPhanelData,
                                    arguments: user.requestKey);
                              }),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              text: label.tr,
              fontsize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start, // Align text to the start (left)
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: value.tr,
              fontsize: 16.sp,
              maxline: 2,
              textAlign: TextAlign.start, // Align text to the end (right)
            ),
          ),
        ],
      ),
    );
  }
}
