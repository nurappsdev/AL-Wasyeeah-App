import 'dart:async';

import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/controllers.dart';
import '../widgets/widgets.dart';
import 'before_login/profirty_Distribute_screen2.dart';
import 'no_internet_screen.dart';
import 'package:hijri/hijri_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  Duration? timeLeft;
  String upcomingPrayer = "";
  Map<String, String> prayerTimes = {};

  void _calculateNextPrayer() {
    if (prayerTimes.isEmpty) return;
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    DateTime? nextTime;
    String? nextName;

    for (var entry in prayerTimes.entries) {
      if (entry.value.isEmpty) continue;
      try {
        final time = DateTime.parse("$today ${entry.value}:00");
        if (time.isAfter(now)) {
          nextTime = time;
          nextName = entry.key;
          break;
        }
      } catch (_) {}
    }

    if (nextTime != null && nextName != null) {
      setState(() {
        timeLeft = nextTime!.difference(now);
        upcomingPrayer = nextName!;
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userController.getsalatTimeHandle().then((_) {
  //     final model = userController.getSalatTimeResponseModel.value;
  //     if (model != null) {
  //       prayerTimes = {
  //         'Fajr': model.fajr ?? '',
  //         'Sunrise': model.sunrise ?? '',
  //         'Dhuhr': model.dhuhr ?? '',
  //         'Asr': model.asr ?? '',
  //         'Maghrib': model.maghrib ?? '',
  //         'Isha': model.isha ?? '',
  //       };
  //       _calculateNextPrayer();
  //       timer = Timer.periodic(Duration(seconds: 1), (_) => _calculateNextPrayer());
  //       setState(() {});
  //     }
  //   });
  //   userController.getUserProfileData();
  // }
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    userController.getsalatTimeHandle().then((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        final index = userController.prayerTimes.keys
            .toList()
            .indexOf(userController.upcomingPrayer.value);
        if (index != -1) {
          _scrollController.animateTo(
            index * 250.h,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
      userController.startPrayerTimer();
    });

    userController.getUserProfileData();
  }

  @override
  void dispose() {
    timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  final todayHijri = HijriCalendar.now();
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    print("magrib ${userController.getSalatTimeResponseModel.value?.maghrib}");

    return ConnectivityWrapper(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: AppBar(
            leadingWidth: 200, // Adjust this width to fit your content
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.profileInfo,
                            preventDuplicates: false);
                      },
                      child: CircleAvatar(
                        radius: 18, // Radius of the CircleAvatar
                        backgroundImage: AssetImage(AppImages.profileIcon),
                        backgroundColor:
                            Colors.grey[200], // Optional background color
                      )
                      // CustomNetworkImage(
                      //   boxShape: BoxShape.circle,
                      //   imageUrl: AppImages.profileImage,
                      //   height: 40,
                      //   width: 40,
                      //   boxFit: BoxFit.contain,
                      // ),
                      ),
                  SizedBox(width: 8.h), // Space between the image and text
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Obx(
                  //       () => userController.isLoadingUserProfile.value
                  //           ? CustomLoader()
                  //           : CustomText(
                  //               text: userController
                  //                       .userProfile.value?.firstName ??
                  //                   "N/A",
                  //               fontsize: 16.sp,
                  //               textAlign: TextAlign.start,
                  //             ),
                  //     ),
                  //     CustomText(
                  //       text: "Welcome back!".tr,
                  //       fontsize: 14.sp,
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ],
                  // ),
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
                        Get.toNamed(AppRoutes.notificationsScreen,
                            preventDuplicates: false);
                        // Handle notification click
                      },
                    ),
                    Positioned(
                      right: 14,
                      top: 10,
                      child: Container(
                        height: 16,
                        width: 16,
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
        ),
        body: BackgroundImageContainer(
          child: Container(
            height: Get.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),

                    ///=======================Explore your \n Wasyyah==========================

                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.wasyyahScreen,
                            preventDuplicates: false);
                      },
                      child: Container(
                        height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              AppIcons.exploreWasyea,
                              width: 80.w,
                              height: 80.h,
                            ),
                            CustomText(
                              text: "Explore your \n Wasyyah".tr,
                              fontsize: 18.sp,
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///=======================Witness \n Nominee==========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.witnessTabScreen,
                                  preventDuplicates: false);
                            },
                            child: Container(
                              height: 100.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.witness,
                                    width: 50.w,
                                    height: 50.h,
                                  ),
                                  CustomText(
                                    text: "Witness".tr,
                                    fontsize: 18.sp,
                                    color: AppColors.textColor4E4E4E,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///======================Nominee====================
                        SizedBox(
                          width: 6.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.nomineeTabScreen,
                                  preventDuplicates: false);
                            },
                            child: Container(
                              height: 100.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.nominee,
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  CustomText(
                                    text: "Nominee".tr,
                                    fontsize: 18.sp,
                                    color: AppColors.textColor4E4E4E,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Prayer Times",
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700])),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 12.h),
                            Text(
                                DateFormat('dd MMM, yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.black)),
                            SizedBox(height: 4.h),
                            Text(
                              todayHijri.toFormat(
                                  "dd MMMM, yyyy"), // Example: 26 Muharram, 1447
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() {
                      final prayers = userController.prayerTimes;
                      final current = userController.upcomingPrayer.value;
                      final left = userController.timeLeft.value;

                      if (prayers.isEmpty) {
                        return SizedBox(
                          height: 200.h,
                          child: GridView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 20,
                                          width: 120,
                                          color: Colors.grey.shade300),
                                      SizedBox(height: 8.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              height: 80.h,
                                              width: 80,
                                              color: Colors.grey.shade300),
                                          Column(
                                            children: List.generate(
                                                4,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0),
                                                      child: Container(
                                                          height: 20,
                                                          width:
                                                              60 + index * 10,
                                                          color: Colors
                                                              .grey.shade300),
                                                    )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: prayers.length,
                          itemBuilder: (context, index) {
                            final name = prayers.keys.elementAt(index);
                            final time = prayers[name]!;
                            final isCurrent = name == current;

                            return Card(
                              color: isCurrent
                                  ? Color(0xffFFF0E2)
                                  : Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      isCurrent
                                          ? "Upcoming Prayers"
                                          : "Prayer Time",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrent
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(AppImages.mosjidIcon,
                                            height: 80.h, width: 80),
                                        Column(
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: isCurrent
                                                      ? Colors.green
                                                      : Colors.red),
                                            ),
                                            if (isCurrent && left != null)
                                              Text(
                                                left.toString().split(".")[0],
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.black87),
                                              ),
                                            Text(
                                              formatTime(time),
                                              style: TextStyle(fontSize: 14.h),
                                            ),
                                            Switch(
                                              value: isCurrent,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                // handle toggle
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
                          },
                        ),
                      );
                    }),

                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const SizedBox(height: 50),
                    //       Text("Prayer Times ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[700])),
                    //       const SizedBox(height: 8),
                    //       Text(DateFormat('d MMM, yyyy').format(DateTime.now()), style: TextStyle(fontSize: 14, color: Colors.black)),
                    //       const SizedBox(height: 4),
                    //       Text(
                    //         todayHijri.toFormat("dd MMMM, yyyy"), // Example: 26 Muharram, 1447
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color: Colors.green[800],
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 24),
                    //       if (prayerTimes.isNotEmpty)
                    //         SizedBox(
                    //           height: 160,
                    //           child: ListView.separated(
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: prayerTimes.length,
                    //             separatorBuilder: (_, __) => SizedBox(width: 12),
                    //             itemBuilder: (context, index) {
                    //               String name = prayerTimes.keys.elementAt(index);
                    //               String time = prayerTimes[name]!;
                    //
                    //               bool isActive = name == upcomingPrayer;
                    //
                    //               return AnimatedContainer(
                    //                 duration: Duration(milliseconds: 300),
                    //                 width: 130,
                    //                 padding: EdgeInsets.all(12),
                    //                 decoration: BoxDecoration(
                    //                   color: isActive ? Colors.black87 : Colors.grey[200],
                    //                   borderRadius: BorderRadius.circular(12),
                    //                 ),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.center,
                    //                   children: [
                    //                     Text(
                    //                       name,
                    //                       style: TextStyle(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold,
                    //                         color: isActive ? Colors.white : Colors.black,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 6),
                    //                     if (isActive && timeLeft != null)
                    //                       Column(
                    //                         children: [
                    //                           Text(
                    //                             "Upcoming Prayers",
                    //                             style: TextStyle(fontSize: 12, color: Colors.white),
                    //                           ),
                    //                           Text(
                    //                             timeLeft!.toString().split(".")[0],
                    //                             style: TextStyle(fontSize: 18, color: Colors.white),
                    //                           ),
                    //                           const SizedBox(height: 4),
                    //                           Text(
                    //                             formatTime(time),
                    //                             style: TextStyle(fontSize: 14, color: Colors.white),
                    //                           ),
                    //                         ],
                    //                       )
                    //                     else
                    //                       Text(
                    //                         formatTime(time),
                    //                         style: TextStyle(fontSize: 16, color: Colors.black),
                    //                       ),
                    //                   ],
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         )
                    //       else
                    //         Center(child: CustomLoader()),
                    //
                    //
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 200.h,
                    //   width: double.infinity,
                    //   child: prayerTimes.isNotEmpty
                    //       ? GridView.builder(
                    //     controller: _scrollController, // 👉 attach controller here
                    //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //     scrollDirection: Axis.horizontal,
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 1,
                    //       mainAxisSpacing: 16.0,
                    //       childAspectRatio: 0.8,
                    //     ),
                    //     itemCount: prayerTimes.length,
                    //     physics: const BouncingScrollPhysics(),
                    //     itemBuilder: (context, index) {
                    //       final name = prayerTimes.keys.elementAt(index);
                    //       final time = prayerTimes[name]!;
                    //       final isCurrent = name == upcomingPrayer;
                    //
                    //       return Card(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12.0),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 isCurrent ? "Upcoming Prayers" : "Prayer Time",
                    //                 style: TextStyle(
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: isCurrent ? Colors.green : Colors.orange,
                    //                 ),
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                 children: [
                    //                   Image.asset(AppImages.mosjidIcon, height: 80.h, width: 80),
                    //                   Column(
                    //                     children: [
                    //                       Text(
                    //                         name,
                    //                         style: const TextStyle(fontSize: 18.0, color: Colors.red),
                    //                       ),
                    //                       if (isCurrent && timeLeft != null)
                    //                         Text(
                    //                           timeLeft!.toString().split(".")[0],
                    //                           style: TextStyle(fontSize: 18.sp, color: Colors.black87),
                    //                         ),
                    //                       Text(
                    //                         formatTime(time),
                    //                         style: TextStyle(fontSize: 14.h),
                    //                       ),
                    //                       Switch(
                    //                         value: isCurrent ? true : false,
                    //                         activeColor: AppColors.primaryColor,
                    //                         onChanged: (value) {
                    //                           // notification toggle logic
                    //                         },
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   )
                    //       : const Center(child: CircularProgressIndicator()),
                    // ),
                    ///==========================Zakat distribute======================
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.zakatCalculatorScreen,
                            preventDuplicates: false);
                      },
                      child: SizedBox(
                        height: 200.h,
                        child: Image.asset(AppImages.zakatImg),
                      ),
                    ),

                    ///==========================property distribute======================
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(() => PropertyDistributionScreen2(),
                            preventDuplicates: false);
                      },
                      child: SizedBox(
                        height: 200.h,
                        child: Image.asset(AppImages.profirtyImg),
                      ),
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(String time24) {
    try {
      final dt = DateFormat("HH:mm").parse(time24);
      return DateFormat("hh:mm a").format(dt);
    } catch (e) {
      return time24;
    }
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
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SvgPicture.asset(imageUrl, height: 80.h),
                Image.asset(
                  imageUrl,
                  height: 80.h,
                  width: 80,
                ),
                Column(
                  children: [
                    Text(
                      "Isha".tr,
                      style: const TextStyle(fontSize: 18.0, color: Colors.red),
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
