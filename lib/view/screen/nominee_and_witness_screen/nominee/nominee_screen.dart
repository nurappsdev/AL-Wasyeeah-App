import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/background_image_screen_widget.dart';
import '../../../widgets/widgets.dart';


class NomineeScreen extends StatefulWidget {
  const NomineeScreen({super.key, required this.tabController});
final TabController tabController;
  @override
  State<NomineeScreen> createState() => _NomineeScreenState();
}

class _NomineeScreenState extends State<NomineeScreen> {


  NomineeController nomineeController = Get.put(NomineeController());
  @override
  Widget build(BuildContext context) {
    nomineeController.getNomineeData();
    print(nomineeController.nomineeData.length);
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
                    title: "+ Add more nominees".tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                        Get.toNamed(AppRoutes.addNomineeScreen,preventDuplicates: false);
                    },
                  ),
                  SizedBox(height: 10.h),

                     SizedBox(
                      height: 450.0, // Adjust height as per your needs
                      child: Obx(()=> nomineeController.isNominee.value ? CustomLoader(): nomineeController.nomineeData.isEmpty ?Center(child: CustomText(text: "No Nominee data",),) :
                          ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: nomineeController.nomineeData.length,
                          itemBuilder: (context, index) {
                            final user = nomineeController.nomineeData[index];
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
                                  user.name ?? "N/A",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "View Details".tr,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  showWitnessDetailsDialog(context, user);
                               //   Get.toNamed(AppRoutes.nomineeDetailsScreen, preventDuplicates: false);
                                  print("Tapped on");
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
  void showWitnessDetailsDialog(BuildContext context, NomineetedResponseModel user) {
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
                            user.name ?? "N/A",
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
                    _buildDialogRow(Icons.people, "Relation", user.relation ?? "N/A"),
                    _buildDialogRow(Icons.email, "Email", user.email ?? "N/A"),
                    _buildDialogRow(Icons.person, "Father Name", user.fatherName ?? "N/A"),
                    _buildDialogRow(Icons.phone, "Mobile", user.mobile ?? "N/A"),
                    _buildDialogRow(Icons.favorite, "Marital Status", user.maritalStatus ?? "N/A"),
                    _buildDialogRow(Icons.work, "Profession", user.profession ?? "N/A"),
                    _buildDialogRow(Icons.calendar_today, "Date", "${DateFormat('dd-MM-yyyy').format(DateTime.parse(user.wnDate.toString()))}" ?? "N/A"),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        // Implement remove witness logic
                        Navigator.pop(context);
                      },
                      child: Text("Remove Witness"),
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
