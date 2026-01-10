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
                              Get.to(
                                    () => WitnessDetailsScreens(user: user),
                                preventDuplicates: false,
                              );
                              print("Tapped on");

                              //showWitnessDetailsDialog()
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

 // void showWitnessDetailsDialog(BuildContext context, GetWitnessResponseModel user) {
 //   showDialog(
 //     context: context,
 //     builder: (context) {
 //       return Dialog(
 //         backgroundColor: Colors.transparent,
 //         insetPadding: EdgeInsets.all(16),
 //         child: Padding(
 //           padding: const EdgeInsets.all(8.0),
 //           child: SingleChildScrollView(
 //             child: Container(
 //               decoration: BoxDecoration(
 //                 color: Colors.blueGrey[900],
 //                 borderRadius: BorderRadius.circular(12),
 //               ),
 //               padding: const EdgeInsets.all(16.0),
 //               child: Column(
 //                 mainAxisSize: MainAxisSize.min,
 //                 crossAxisAlignment: CrossAxisAlignment.start,
 //                 children: [
 //                   Row(
 //                     children: [
 //                       Expanded(
 //                         child: Text(
 //                           user.name ?? "N/A",
 //                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
 //                         ),
 //                       ),
 //                       IconButton(
 //                         icon: Icon(Icons.close, color: Colors.white),
 //                         onPressed: () => Navigator.pop(context),
 //                       ),
 //                     ],
 //                   ),
 //                   Divider(color: Colors.white70),
 //                   _buildDialogRow(Icons.people, "Relation", user.relation ?? "N/A"),
 //                   _buildDialogRow(Icons.email, "Email", user.email ?? "N/A"),
 //                   _buildDialogRow(Icons.person, "Father Name", user.fatherName ?? "N/A"),
 //                   _buildDialogRow(Icons.phone, "Mobile", user.mobile ?? "N/A"),
 //                   _buildDialogRow(Icons.favorite, "Marital Status", user.maritalStatus ?? "N/A"),
 //                   _buildDialogRow(Icons.work, "Profession", user.profession ?? "N/A"),
 //                   SizedBox(height: 20),
 //                   ElevatedButton(
 //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
 //                     onPressed: () {
 //                       // Implement remove witness logic
 //                       Navigator.pop(context);
 //                     },
 //                     child: Text("OK"),
 //                   ),
 //                 ],
 //               ),
 //             ),
 //           ),
 //         ),
 //       );
 //     },
 //   );
 // }

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



class WitnessDetailsScreens extends StatelessWidget {
  final GetWitnessResponseModel user;


   WitnessDetailsScreens({super.key, required this.user});
  WitnessController witnessController = Get.put(WitnessController());
  @override
  Widget build(BuildContext context) {
    print(user.requestKey.toString());
   // witnessController.fetchContextsData("8E1087C1C3F54338C3313F40B6FFAD00");
    print(witnessController.contextsData.value?.zakat?.currencyCode);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(user.name ?? "Witness Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDialogRow(Icons.people, "Relation", user.relation ?? "N/A"),
              _buildDialogRow(Icons.email, "Email", user.email ?? "N/A"),
              _buildDialogRow(Icons.person, "Father Name", user.fatherName ?? "N/A"),
              _buildDialogRow(Icons.phone, "Mobile", user.mobile ?? "N/A"),
              _buildDialogRow(Icons.favorite, "Marital Status", user.maritalStatus ?? "N/A"),
              _buildDialogRow(Icons.work, "Profession", user.profession ?? "N/A"),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                  Get.toNamed(AppRoutes.witnessPhanelData,arguments: user.requestKey);
                  },
                  child: const Text("Access Panel"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDialogRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
