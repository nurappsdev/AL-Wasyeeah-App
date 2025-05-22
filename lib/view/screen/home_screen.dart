
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/widgets.dart';
import 'before_login/profirty_Distribute_screen2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200, // Adjust this width to fit your content
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.profileInfo,preventDuplicates: false);
                },
                child: CircleAvatar(
                  radius: 18, // Radius of the CircleAvatar
                  backgroundImage: AssetImage(AppImages.profileIcon),
                  backgroundColor: Colors.grey[200], // Optional background color
                )
                // CustomNetworkImage(
                //   boxShape: BoxShape.circle,
                //   imageUrl: AppImages.profileImage,
                //   height: 40,
                //   width: 40,
                //   boxFit: BoxFit.contain,
                // ),
              ),
              SizedBox(width: 8), // Space between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Abdullah".tr,
                    fontsize: 16.sp,
                    textAlign: TextAlign.start,
                  ),
                  CustomText(
                    text: "Welcome back!".tr,
                    fontsize: 14.sp,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_sharp),
                  onPressed: () {
                    Get.toNamed(AppRoutes.notificationsScreen,preventDuplicates: false);
                    // Handle notification click
                  },
                ),
                Positioned(
                  right: 14,
                  top: 10,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  ///=======================Explore your \n Wasyyah==========================
        
        
        
                  InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.wasyyahScreen,preventDuplicates: false);
                    },
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(AppIcons.exploreWasyea, width: 80.w,height: 80.h,),
                          CustomText(text: "Explore your \n Wasyyah".tr,fontsize: 18.sp,color: AppColors.primaryColor,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

        
        
                  ///=======================Witness \n Nominee==========================
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.witnessTabScreen,preventDuplicates: false);
                          },
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(AppIcons.witness, width: 50.w,height: 50.h,),
                                CustomText(text: "Witness".tr,fontsize: 18.sp,color: AppColors.textColor4E4E4E,)
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///======================Nominee====================
                      SizedBox(width: 6.w,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.nomineeTabScreen,preventDuplicates: false);
                          },
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(AppIcons.nominee, width: 40.w,height: 40.h,),
                                CustomText(text: "Nominee".tr,fontsize: 18.sp,color: AppColors.textColor4E4E4E,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ///========================"Prayer Time"======================

                  SizedBox(height: 20.h),
                  CustomText(text: "Prayer Time".tr,fontsize: 20.sp,fontWeight: FontWeight.w700,),
                  SizedBox(height: 10.h),
                  CustomText(text: "15 Sep, 2024 - 10 Rabi al-Awwal, 1146 Hijri".tr,fontsize: 14.sp,),
                  SizedBox(height: 20.h,),
                   SizedBox(
                height: 170,
                width: double.infinity,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.8, // Adjust to match your card's aspect ratio
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      title: "Now Time is",
                      imageUrl: AppImages.mosjidIcon,
                      isCurrent: true,
                      time: "07:23 PM", // Pass index or other data if needed
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                ),
              ),

                  ///==========================Zakat distribute======================
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.zakatCalculatorScreen,preventDuplicates: false);
                    },
                    child: SizedBox(height: 200.h,
                      child: Image.asset(AppImages.zakatImg),

                    ),
                  ),

                  ///==========================property distribute======================
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: (){
                      Get.off(()=>PropertyDistributionScreen2(),preventDuplicates: false);
                    },
                    child: SizedBox(height: 200.h,
                      child: Image.asset(AppImages.profirtyImg),

                    ),
                  ),

                  SizedBox(height: 40.h,),

              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String time;
  final String imageUrl;
  final bool isCurrent;

  const CustomCard({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.isCurrent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isCurrent ? Colors.green : Colors.orange,
              ),
            ),
            SizedBox(height: 8.h,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SvgPicture.asset(imageUrl, height: 80.h),
                Image.asset(imageUrl,height: 80.h,width: 80,),
                Column(
                  children: [
                    Text(
                      "Isha".tr,
                      style: const TextStyle(fontSize: 18.0,color: Colors.red),
                    ),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Switch(
                      value: true,
                      activeColor: AppColors.primaryColor,
                      onChanged: (value) {
                        // Handle switch logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

