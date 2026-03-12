import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/controllers.dart';
import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

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
                  //   title: AppLocalizations.of(context)!.add_more_witness,
                  //   titlecolor: AppColors.primaryColor,
                  //   onpress: () {
                  //     Get.toNamed(AppRoutes.addWitnessesScreen,preventDuplicates: false);
                  //   },
                  // ),
                  // SizedBox(height: 10.h),

                  SizedBox(
                    height: 450.0, // Adjust height as per your needs
                    child: Obx(
                      () => witnessController.isWitnessesYou.value
                          ? CustomLoader()
                          : witnessController.witnessesYouData.isEmpty
                              ? Center(
                                  child: CustomText(
                                    text: "No Nominee data",
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(8.0),
                                  itemCount:
                                      witnessController.witnessesYouData.length,
                                  itemBuilder: (context, index) {
                                    final user = witnessController
                                        .witnessesYouData[index];
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
                                          user.name ??
                                              "AppLocalizations.of(context)!.n_a",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Icon(Icons.visibility,
                                                size: 16.0, color: Colors.grey),
                                            SizedBox(width: 4.0),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .view_details,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // Get.to(
                                          //       () => WitnessDetailsScreens(user: user),
                                          //   preventDuplicates: false,
                                          // );
                                          Get.toNamed(
                                              AppRoutes.witnessDetailsScreen,
                                              arguments: user,
                                              preventDuplicates: false);
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
}

class WitnessDetailsScreens extends StatefulWidget {
  final GetWitnessResponseModel user;

  const WitnessDetailsScreens({super.key, required this.user});

  @override
  State<WitnessDetailsScreens> createState() => _WitnessDetailsScreensState();
}

class _WitnessDetailsScreensState extends State<WitnessDetailsScreens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.requestKey.toString());

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
              _buildDialogRow(Icons.people, "Relation",
                  widget.user.relation ?? "AppLocalizations.of(context)!.n_a"),
              _buildDialogRow(Icons.email, "Email",
                  widget.user.email ?? "AppLocalizations.of(context)!.n_a"),
              _buildDialogRow(
                  Icons.person,
                  "Father Name",
                  widget.user.fatherName ??
                      "AppLocalizations.of(context)!.n_a"),
              _buildDialogRow(Icons.phone, "Mobile",
                  widget.user.mobile ?? "AppLocalizations.of(context)!.n_a"),
              _buildDialogRow(
                  Icons.favorite,
                  "Marital Status",
                  widget.user.maritalStatus ??
                      "AppLocalizations.of(context)!.n_a"),
              _buildDialogRow(
                  Icons.work,
                  "Profession",
                  widget.user.profession ??
                      "AppLocalizations.of(context)!.n_a"),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.witnessPhanelData,
                        arguments: widget.user.requestKey);
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
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
