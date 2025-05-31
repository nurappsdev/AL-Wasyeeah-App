import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../../../controllers/controllers.dart';
import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class YourWitnessScreen extends StatefulWidget {
  const YourWitnessScreen({super.key, required this.tabController});
  final TabController tabController;
  @override
  State<YourWitnessScreen> createState() => _NomineeScreenState();
}

class _NomineeScreenState extends State<YourWitnessScreen> {


 WitnessController witnessController = Get.put(WitnessController());
  @override
  Widget build(BuildContext context) {
    witnessController.getWitnessesYouData();
    print(witnessController.witnessesYouData.length);
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
                    title: "+ Add more witness".tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addWitnessesScreen,preventDuplicates: false);
                    },
                  ),
                  SizedBox(height: 10.h),

                  SizedBox(
                    height: 450.0, // Adjust height as per your needs
                    child: Obx(()=> witnessController.isWitnessesYou.value ? CustomLoader(): witnessController.witnessesYouData.isEmpty ?Center(child: CustomText(text: "No Nominee data",),) :
                    ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: witnessController.witnessesYouData.length,
                      itemBuilder: (context, index) {
                        final user = witnessController.witnessesYouData[index];
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
                              // Get.toNamed(AppRoutes.witnessDetailsScreen,
                              //     arguments: user,
                              //     preventDuplicates: false);
                              showWitnessDetailsDialog(context,user);
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

 void showWitnessDetailsDialog(BuildContext context, GetWitnessResponseModel user) {
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
