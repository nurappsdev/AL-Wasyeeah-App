import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/controllers.dart';
import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class NomineetedYouScreen extends StatefulWidget {
  const NomineetedYouScreen({super.key, required this.tabController});
  final TabController tabController;
  @override
  State<NomineetedYouScreen> createState() => _NomineetedYouScreenState();
}

class _NomineetedYouScreenState extends State<NomineetedYouScreen> {
  NomineeController nomineeController = Get.find<NomineeController>();
  @override
  Widget build(BuildContext context) {
    nomineeController.getNomineetedData();
    print(nomineeController.nomineetedYouData.length);
    return Scaffold(
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CustomButton(
                    title: 'addMoreNominees'.tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addNomineeScreen,
                          preventDuplicates: false);
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 450.0, // Adjust height as per your needs
                    child: Obx(
                      () => nomineeController.isNomineeYou.value
                          ? CustomLoader()
                          : nomineeController.nomineetedYouData.isEmpty
                              ? Center(
                                  child: CustomText(
                                    text: 'noNomineeData'.tr,
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(8.0),
                                  itemCount: nomineeController
                                      .nomineetedYouData.length,
                                  itemBuilder: (context, index) {
                                    final user = nomineeController
                                        .nomineetedYouData[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      elevation: 3.0,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListTile(
                                        // leading: CircleAvatar(
                                        //   backgroundImage: AssetImage(user["image"]!),
                                        //   radius: 30,
                                        // ),
                                        title: Text(
                                          user.name ?? "N/A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Icon(Icons.visibility,
                                                size: 16.0, color: Colors.grey),
                                            SizedBox(width: 4.0),
                                            Text(
                                              'viewDetails'.tr,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          showWitnessDetailsDialog(
                                              context, user, nomineeController);
                                          //   Get.toNamed(AppRoutes.nomineeDetailsScreen, preventDuplicates: false);
                                          print("Tapped on");
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showWitnessDetailsDialog(BuildContext context,
      NomineetedResponseModel user, NomineeController nomineeController) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name ?? "N/A",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white70),
                    _buildDialogRow(
                        Icons.people, 'relation'.tr, user.relation ?? "N/A"),
                    _buildDialogRow(
                        Icons.email, 'email'.tr, user.email ?? "N/A"),
                    _buildDialogRow(Icons.person, 'fatherName'.tr,
                        user.fatherName ?? "N/A"),
                    _buildDialogRow(
                        Icons.phone, 'mobile'.tr, user.mobile ?? "N/A"),
                    _buildDialogRow(Icons.favorite, 'maritalStatus'.tr,
                        user.maritalStatus ?? "N/A"),
                    _buildDialogRow(
                        Icons.work, 'profession'.tr, user.profession ?? "N/A"),
                    _buildDialogRow(
                        Icons.calendar_today,
                        'date'.tr,
                        "${DateFormat('dd-MM-yyyy').format(DateTime.parse(user.wnDate.toString()))}" ??
                            "N/A"),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        // Implement remove witness logic
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ok'.tr,
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
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
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 18),
          SizedBox(width: 10),
          Text("$label: ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(value, style: TextStyle(color: Colors.orangeAccent))),
        ],
      ),
    );
  }
}
