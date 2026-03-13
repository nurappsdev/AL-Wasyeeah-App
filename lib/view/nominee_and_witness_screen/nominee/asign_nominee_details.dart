import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/nomineee/nominee_controller.dart';
import '../../../models/nominee/search_asign_nominee_model.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class AsignNomineeDetails extends StatelessWidget {
  AsignNomineeDetails({super.key});
  final SearchAsignResponseModel user =
      Get.arguments as SearchAsignResponseModel;
  final String type = Get.parameters["type"] ?? "";
  @override
  Widget build(BuildContext context) {
    NomineeController controller = Get.put(NomineeController());
    print(type);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: type == "WITNESS"
              ? AppLocalizations.of(context)!.witness_profile_details
              : AppLocalizations.of(context)!.nominee_profile_details,
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

                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.relation,
                              "${user.relation ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.mobile,
                              "${user.mobile ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.profession,
                              "${user.profession ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.email,
                              "${user.email ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.marital_status,
                              "${user.maritalStatus ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.mother_s_name_1,
                              "${user.motherName ?? AppLocalizations.of(context)!.n_a}"),
                          _buildRow(
                              context,
                              AppLocalizations.of(context)!.father_s_name_1,
                              "${user.fatherName ?? AppLocalizations.of(context)!.n_a}"),

                          /// Buttons
                          SizedBox(height: 30.h),
                          Obx(
                            () => CustomButtonCommon(
                              loading: controller.isAssignYou.value,
                              title: type == "WITNESS"
                                  ? AppLocalizations.of(context)!.assign_witness
                                  : AppLocalizations.of(context)!
                                      .assign_nominee,
                              onpress: () {
                                controller.assignNomineeWitnessData(
                                  email: controller.nominessData.value?.email
                                      .toString(),
                                  type: type,
                                );
                              },
                            ),
                          ),

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

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              text: label,
              fontsize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start, // Align text to the start (left)
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: value,
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
