import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class WitnessesYouScreen extends StatefulWidget {
  const WitnessesYouScreen({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<WitnessesYouScreen> createState() => _WitnessesYouScreenState();
}

class _WitnessesYouScreenState extends State<WitnessesYouScreen> {
  WitnessController witnessController = Get.put(WitnessController());
  @override
  Widget build(BuildContext context) {
    witnessController.getWitnessData();
    print(witnessController.witnessData.length);
    return Scaffold(
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
                  CustomButton(
                    title: AppLocalizations.of(context)!.add_more_witness,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addWitnessesScreen, preventDuplicates: false);
                    },
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 450.0, // Adjust height as per your needs
                    child: Obx(
                      () => witnessController.isWitness.value
                          ? CustomLoader()
                          : witnessController.witnessData.isEmpty
                              ? Center(
                                  child: CustomText(
                                    text: AppLocalizations.of(context)!.no_data,
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(8.0),
                                  itemCount: witnessController.witnessData.length,
                                  itemBuilder: (context, index) {
                                    final user = witnessController.witnessData[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 3.0,
                                      margin: EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListTile(
                                        // leading: CircleAvatar(
                                        //   backgroundImage: AssetImage(user["image"]!),
                                        //   radius: 30,
                                        // ),
                                        title: Text(
                                          user.name ?? AppLocalizations.of(context)!.n_a,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                                            SizedBox(width: 4.0),
                                            Text(
                                              AppLocalizations.of(context)!.view_details,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // Get.toNamed(AppRoutes.witnessDetailsScreen,preventDuplicates: false);
                                          showWitnessDetailsDialog(context, user, witnessController);
                                          //   Get.toNamed(AppRoutes.nomineeDetailsScreen, preventDuplicates: false);
                                        },
                                      ),
                                    );
                                  },
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

  void showWitnessDetailsDialog(BuildContext context, GetWitnessResponseModel user, WitnessController witnessController) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name ?? AppLocalizations.of(context)!.n_a,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white70),
                    _buildDialogRow(Icons.people, AppLocalizations.of(context)!.relation, user.relation ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.email, AppLocalizations.of(context)!.email, user.email ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.person, AppLocalizations.of(context)!.father_s_information, user.fatherName ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.phone, AppLocalizations.of(context)!.mobile, user.mobile ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.favorite, AppLocalizations.of(context)!.marital_status, user.maritalStatus ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.work, AppLocalizations.of(context)!.profession, user.profession ?? AppLocalizations.of(context)!.n_a),
                    _buildDialogRow(Icons.calendar_today, AppLocalizations.of(context)!.date, "${DateFormat('dd-MM-yyyy').format(DateTime.parse(user.wnDate.toString()))}"),
                    SizedBox(height: 20),
                    Obx(() => CustomButtonCommon(
                        title: AppLocalizations.of(context)!.remove_witness_btn,
                        color: AppColors.redColor,
                        loading: witnessController.isDelNomineeYou.value == true,
                        onpress: () {
                          print(user.requestKey);
                          witnessController.getWitnessDeleteData(requestKey: user.requestKey);
                          Get.back();
                        }))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 18),
          SizedBox(width: 10),
          Text("$label: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(color: Colors.orangeAccent))),
        ],
      ),
    );
  }
}
