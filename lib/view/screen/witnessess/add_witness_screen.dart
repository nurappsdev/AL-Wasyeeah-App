import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class AddWitnessScreen extends StatelessWidget {
   AddWitnessScreen({super.key});
   List<bool> isSelected = [true, false];
   final List<Map<String, String>> user= [
     {
       "name": "Khadijah",
       "image": "https://via.placeholder.com/150",
     },
     {
       "name": "Shahriar Hasan",
       "image": "https://via.placeholder.com/150",
     },
   ];
  @override
  Widget build(BuildContext context) {

    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Add Witness".tr,fontsize: 18. sp,),),
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
                  ///=============Last Name====================
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: searchController,
                      hintText: "Search".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      suffixIcon: Icon(Icons.search_rounded,color: AppColors.primaryColor,),
                    ),
                  ),
                  SizedBox(
                    height: 500.0, // Adjust height as per your needs
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        final users = user[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(users["image"]!),
                              radius: 30,
                            ),
                            title: Text(
                              users["name"]!,
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
                              Get.toNamed(AppRoutes.witnessDetailsScreen, preventDuplicates: false);
                              print("Tapped on ${users['name']}");
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),
                  CustomButton(
                    title: "+ Add outside witness".tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addWitnessesScreen,preventDuplicates: false);
                    },
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
