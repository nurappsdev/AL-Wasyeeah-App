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
                  // CustomButton(
                  //   title: "+ Add more witness".tr,
                  //   titlecolor: AppColors.primaryColor,
                  //   onpress: () {
                  //     Get.toNamed(AppRoutes.addWitnessesScreen,preventDuplicates: false);
                  //   },
                  // ),
                  // SizedBox(height: 10.h),

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
                              // Get.to(
                              //       () => WitnessDetailsScreens(user: user),
                              //   preventDuplicates: false,
                              // );
                              Get.toNamed(AppRoutes.witnessDetailsScreen,arguments: user, preventDuplicates: false);
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



class WitnessDetailsScreens extends StatefulWidget {
  final GetWitnessResponseModel user;

  const WitnessDetailsScreens({super.key, required this.user});

  @override
  State<WitnessDetailsScreens> createState() =>
      _WitnessDetailsScreensState();
}

class _WitnessDetailsScreensState extends State<WitnessDetailsScreens> {
  // final WitnessController witnessController =
  // Get.put(WitnessController());

  @override
  void initState() {
    super.initState();
   // witnessController.getContextsData(widget.user.requestKey!);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.user.requestKey.toString());
    // witnessController.getContextsData(
    //   widget.user.requestKey.toString(),
    // );
    //witnessController.fetchContextsData("8E1087C1C3F54338C3313F40B6FFAD00");
    // print(witnessController.contextsData.value?.zakat?.currencyCode);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.user.name ?? "Witness Details"),
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
              _buildDialogRow(Icons.people, "Relation", widget.user.relation ?? "N/A"),
              _buildDialogRow(Icons.email, "Email", widget.user.email ?? "N/A"),
              _buildDialogRow(Icons.person, "Father Name", widget.user.fatherName ?? "N/A"),
              _buildDialogRow(Icons.phone, "Mobile", widget.user.mobile ?? "N/A"),
              _buildDialogRow(Icons.favorite, "Marital Status", widget.user.maritalStatus ?? "N/A"),
              _buildDialogRow(Icons.work, "Profession", widget.user.profession ?? "N/A"),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                  Get.toNamed(AppRoutes.witnessPhanelData,arguments: widget.user.requestKey);
                  },
                  child: const Text("Access Panel"),
                ),
              ),


              // Obx(() {
              //   if (witnessController.isLoadings.value) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   }
              //
              //   return Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Zakat: ${witnessController.zakat['zakatAmount'] ?? 'N/A'}',
              //         style: const TextStyle(color: Colors.white),
              //       ),
              //       const SizedBox(height: 8),
              //       Text(
              //         'Total Asset: ${witnessController.zakat['totalAsset'] ?? 'N/A'}',
              //         style: const TextStyle(color: Colors.white),
              //       ),
              //       const Divider(color: Colors.white),
              //       const Text(
              //         'Wasiyyah Content',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //       const SizedBox(height: 8),
              //
              //       ...witnessController.wasiyyahContent.map(
              //             (item) =>
              //
              //                 Container(
              //           margin: const EdgeInsets.only(bottom: 12),
              //           padding: const EdgeInsets.all(12),
              //           decoration: BoxDecoration(
              //             color: Colors.blueGrey[800],
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 item['title'] ?? '',
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               const SizedBox(height: 6),
              //
              //
              //               Text(
              //                 item['content'] ?? '',
              //                 style: const TextStyle(color: Colors.white70),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ).toList(),
              //     ],
              //   );
              // }),


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



