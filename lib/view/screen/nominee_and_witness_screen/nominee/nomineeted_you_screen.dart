
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/controllers.dart';
import '../../../../helpers/helpers.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class NomineetedYouScreen extends StatefulWidget {
  const NomineetedYouScreen({super.key, required this.tabController});
final TabController tabController;
  @override
  State<NomineetedYouScreen> createState() => _NomineetedYouScreenState();
}

class _NomineetedYouScreenState extends State<NomineetedYouScreen> {
  NomineeController nomineeController = Get.put(NomineeController());
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
                    child: Obx(()=> nomineeController.isNomineeYou.value ? CustomLoader(): nomineeController.nomineetedYouData.isEmpty ?Center(child: CustomText(text: "No Nominee data",),) :
                    ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: nomineeController.nomineetedYouData.length,
                      itemBuilder: (context, index) {
                        final user = nomineeController.nomineetedYouData[index];
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
}
