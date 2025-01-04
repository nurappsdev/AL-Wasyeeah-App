import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class NomineeScreen extends StatefulWidget {
  const NomineeScreen({super.key});

  @override
  State<NomineeScreen> createState() => _NomineeScreenState();
}

class _NomineeScreenState extends State<NomineeScreen> {
  List<bool> isSelected = [true, false];
  final List<Map<String, String>> users = [
    {
      "name": "Mahmudul Hasan Rabbi",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Shahriar Hasan",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Nilufa Yeasmin",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Jannatul Maowa",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Mosharaf Kashem Khan",
      "image": "https://via.placeholder.com/150",
    },    {
      "name": "Mosharaf Kashem Khan",
      "image": "https://via.placeholder.com/150",
    },    {
      "name": "Mosharaf Kashem Khan",
      "image": "https://via.placeholder.com/150",
    },    {
      "name": "Mosharaf Kashem Khan",
      "image": "https://via.placeholder.com/150",
    },    {
      "name": "Mosharaf Kashem Khan",
      "image": "https://via.placeholder.com/150",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Nominee".tr,fontsize: 18.sp,),),
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
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ToggleButtons(
                        isSelected: isSelected,
                        onPressed: (index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == index;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        selectedColor: Colors.grey[200],
                        fillColor: isSelected[1] ? Colors.green : Colors.green,
                        color: Colors.black,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Your Nominee'.tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Nominated You'.tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 500.0, // Adjust height as per your needs
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user["image"]!),
                              radius: 30,
                            ),
                            title: Text(
                              user["name"]!,
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
                              Get.toNamed(AppRoutes.nomineeDetailsScreen, preventDuplicates: false);
                              print("Tapped on ${user['name']}");
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    title: "+ Add more nominees".tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addNomineeScreen,preventDuplicates: false);
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
