import 'package:al_wasyeah/controllers/notification/notification_controller.dart';
import 'package:al_wasyeah/controllers/profile/home_controller.dart';
import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  Widget _notificationIconOnly() {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: IconButton(
        icon: const Icon(
          Icons.notifications_outlined,
          size: 26,
        ),
        onPressed: () {
          Get.toNamed(
            AppRoutes.notificationsScreen,
            preventDuplicates: false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          leadingWidth: 200, // Adjust this width to fit your content
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.profileInfo, preventDuplicates: false);
              },
              child: Obx(
                () => Row(
                  children: [
                    profileController.profileModel.value.userProfile
                                ?.profilePictureUrl !=
                            null
                        ? CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                "${ApiConstants.imageUrl + "${profileController.profileModel.value.userProfile?.profilePictureUrl}"}"),
                            backgroundColor: Colors.grey[200],
                          )
                        : CircleAvatar(
                            radius: 18,
                            child: Icon(Icons.person),
                            backgroundColor: Colors.grey[200],
                          ),
                    SizedBox(width: 8.h),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profileController.profileModel.value.userProfile == null
                            ? SizedBox(
                                height: 16.sp,
                                width: 16.sp,
                                child: CustomLoader(),
                              )
                            : Flexible(
                                child: Text(
                                  "${profileController.profileModel.value.userProfile?.firstName} ${profileController.profileModel.value.userProfile?.lastName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                        Text(
                          AppLocalizations.of(context)!.welcome_back,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            notificationController.obx(
              (data) {
                final unreadCount =
                    data!.where((e) => !(e.status != "UNREAD")).length;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// Notification Icon
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          size: 26,
                          color: unreadCount > 0
                              ? Colors.black
                              : Colors.grey.shade700,
                        ),
                        splashRadius: 22,
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.notificationsScreen,
                            preventDuplicates: false,
                          );
                        },
                      ),

                      /// Badge (only if unread > 0)
                      if (unreadCount > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                unreadCount > 99
                                    ? "99+"
                                    : unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },

              /// When loading / empty / error → just show icon without badge
              onLoading: _notificationIconOnly(),
              onEmpty: _notificationIconOnly(),
              onError: (_) => _notificationIconOnly(),
            ),
            SizedBox(width: 8.h), // Space between the image and text
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
                            text: AppLocalizations.of(context)!
                                .explore_your_wasyyah,
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
                            Get.toNamed(AppRoutes.witnessesPage,
                                preventDuplicates: false);
                          },
                          child: Container(
                            height: 100.h,
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
                                  AppIcons.witness,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                CustomText(
                                  text: AppLocalizations.of(context)!.witness,
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
                            Get.toNamed(AppRoutes.nomineePage,
                                preventDuplicates: false);
                          },
                          child: Container(
                            height: 100.h,
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
                                  AppIcons.nominee,
                                  width: 40.w,
                                  height: 40.h,
                                ),
                                CustomText(
                                  text: AppLocalizations.of(context)!.nominee,
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
                    height: 20.h,
                  ),

                  // Current time, sunset, sunrise
                  Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Time Column
                          Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.2)),
                            ),
                            child: Obx(
                              () => CustomText(
                                text: controller.currentTime.value,
                                fontsize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                // maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: AppLocalizations.of(context)!.current_time,
                            fontsize: 12.sp,
                            color: Colors.grey,
                          ),

                          // Sunrise & Sunset Column
                          Obx(
                            () => Skeletonizer(
                              enabled:
                                  controller.salatTimeStatus.value.isLoading,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 4.h),
                                  // Sunrise
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.wb_sunny,
                                              color: Colors.orange,
                                              size: 20.sp),
                                          SizedBox(width: 4.w),
                                          Flexible(
                                            child: CustomText(
                                              text: controller.formatTime(
                                                  controller.salatTimeModel
                                                          .value?.sunrise ??
                                                      "06:00"),
                                              fontsize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              // maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: AppLocalizations.of(context)!
                                            .sunrise_time,
                                        fontsize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),

                                  // Sunset
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.nightlight,
                                              color: Colors.blueGrey,
                                              size: 20.sp),
                                          SizedBox(width: 4.w),
                                          Flexible(
                                            child: CustomText(
                                              text: controller.formatTime(
                                                  controller.salatTimeModel
                                                          .value?.sunset ??
                                                      "18:00"),
                                              fontsize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              // maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: AppLocalizations.of(context)!
                                            .sunset_time,
                                        fontsize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 20.h),

                  // Prayer times
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(AppLocalizations.of(context)!.prayer_times,
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700])),
                  ),
                  SizedBox(height: 20.h),

                  Obx(() {
                    if (controller.salatTimeStatus.value.isError) {
                      return ErrorWidget(Exception(
                          "${controller.salatTimeStatus.value.errorMessage}"));
                    }

                    return SizedBox(
                      height: 220.h,
                      child: Skeletonizer(
                        enabled: controller.salatTimeStatus.value.isLoading,
                        child: ListView.builder(
                          controller: controller.scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.salatTimeStatus.value.isLoading
                              ? 5
                              : controller.prayerTimes.length,
                          itemBuilder: (context, index) {
                            final name = controller
                                    .salatTimeStatus.value.isLoading
                                ? "Prayer Name"
                                : controller.prayerTimes.keys.elementAt(index);
                            final time =
                                controller.salatTimeStatus.value.isLoading
                                    ? "12:00"
                                    : controller.prayerTimes[name]!;
                            final isCurrent =
                                controller.salatTimeStatus.value.isLoading
                                    ? (index == 0)
                                    : name == controller.currentPrayer.value;

                            // Determine gradient based on status
                            // Current: Green, Previous: Grey, Upcoming: Amber
                            // We need to know if it's already passed but not "current".
                            // Actually, if we follow the 3 states:
                            // 1. name == currentPrayer -> Green
                            // 2. index of name < index of currentPrayer -> Grey (already passed)
                            // 3. index of name > index of currentPrayer -> Amber (next or future)

                            final prayerNames =
                                controller.prayerTimes.keys.toList();
                            final currentIndex = prayerNames
                                .indexOf(controller.currentPrayer.value);
                            final pIndex = prayerNames.indexOf(name);

                            LinearGradient gradient;
                            LinearGradient borderGradient;
                            double borderWidth = 1.0;
                            if (isCurrent) {
                              // Current Prayer → Modern Light Green with more white layers
                              gradient = const LinearGradient(
                                colors: [
                                  Color(0xFFFFFFFF), // pure white
                                  Color(0xFFFAFAFA), // ultra light
                                  Color(0xFFF1F8F2), // very light green-white
                                  Color(0xFFDFF5DD), // soft green tint
                                  Color(0xFFC8E6C9), // light green
                                  Color(0xFFA5D6A7), // soft green
                                  Color(0xFF81C784), // main green accent
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );

                              borderGradient = const LinearGradient(
                                colors: [
                                  Color(0xFF81C784), // main green accent
                                  Color(0xFFA5D6A7), // soft green
                                  Color(0xFFC8E6C9), // light green
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );
                            } else if (pIndex < currentIndex &&
                                currentIndex != -1) {
                              // Previous Prayer → Soft Cool Grey with more white layers
                              gradient = const LinearGradient(
                                colors: [
                                  Color(0xFFFFFFFF), // pure white
                                  Color(0xFFFAFAFA), // ultra light
                                  Color(0xFFF5F5F5), // very light grey
                                  Color(0xFFEDEDED), // soft light grey
                                  Color(0xFFE0E0E0), // light grey
                                  Color(0xFFBDBDBD), // grey accent
                                  Color(
                                      0xFF9E9E9E), // slightly darker grey for depth
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );

                              borderGradient = const LinearGradient(
                                colors: [
                                  Color(0xFF9E9E9E), // slightly darker grey
                                  Color(0xFFBDBDBD), // grey accent
                                  Color(0xFFE0E0E0), // light grey
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );
                            } else {
                              // Upcoming Prayer → Modern Light Orange with more white layers
                              gradient = const LinearGradient(
                                colors: [
                                  Color(0xFFFFFFFF), // pure white
                                  Color(0xFFFFFBF0), // ultra light cream
                                  Color(0xFFFFF8E1), // very light yellow-orange
                                  Color(0xFFFFF3C4), // soft pale orange
                                  Color(0xFFFFECB3), // light orange
                                  Color(0xFFFFD54F), // orange accent
                                  Color(0xFFFFB300), // richer orange accent
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );

                              borderGradient = const LinearGradient(
                                colors: [
                                  Color(0xFFFFB300), // rich orange
                                  Color(0xFFFFD54F), // orange accent
                                  Color(0xFFFFECB3), // light orange
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );
                            }

                            return Container(
                              width: 0.6.sw,
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Stack(
                                children: [
                                  // 1. Gradient Border Layer
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient:
                                          borderGradient, // darker/more visible
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),

                                  // 2. Inner Card with Padding for Border Effect
                                  Container(
                                    margin: EdgeInsets.all(
                                        borderWidth), // creates border space
                                    decoration: BoxDecoration(
                                      gradient:
                                          gradient, // keep the light modern gradient
                                      borderRadius: BorderRadius.circular(
                                          16.0 - borderWidth),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Mosque Image
                                        Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                            ),
                                            child: Image.asset(
                                              AppImages.mosjidIcon,
                                              height: 150.h,
                                              width: 150.w,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),

                                        // Content Layer
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // Top Status Text
                                              Text(
                                                isCurrent
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .current_prayer
                                                    : (pIndex < currentIndex &&
                                                            currentIndex != -1)
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .previous_prayer
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .upcoming_prayer,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if (isCurrent)
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .remainingTimeStr.value,
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      letterSpacing: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              const Spacer(),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      name == "Dhuhr"
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .dhuhr
                                                          : name == "Asr"
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .asr
                                                              : name ==
                                                                      "Maghrib"
                                                                  ? AppLocalizations.of(
                                                                          context)!
                                                                      .maghrib
                                                                  : name ==
                                                                          "Isha"
                                                                      ? AppLocalizations.of(
                                                                              context)!
                                                                          .isha
                                                                      : AppLocalizations.of(
                                                                              context)!
                                                                          .fajr,
                                                      style: TextStyle(
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .formatTime(time),
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    SizedBox(
                                                      height: 30.h,
                                                      width: 50.w,
                                                      child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Switch(
                                                          value: isCurrent
                                                              ? true
                                                              : false,
                                                          activeColor: Colors
                                                              .greenAccent[400],
                                                          onChanged: (val) {},
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),

                  ///==========================Zakat distribute======================
                  SizedBox(
                    height: 20.h,
                  ),

                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.zakatCalculatorScreen,
                          preventDuplicates: false);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 220.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.zakatImg),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 90.h,
                          right: 110.w,
                          child: Transform.rotate(
                            angle: 90 * 3.141592653589793 / 160,
                            child: Icon(
                              Icons.calculate,
                              size: 50.sp,
                              color: Color(0xFF2F5ADF),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70.h,
                          right: 40.w,
                          child: SizedBox(
                            width: 60.w,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .calculate_your_zakat,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///==========================property distribute======================
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.propertyDistributionScreen,
                          preventDuplicates: false);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages
                                  .distribureYourPropertyProperlyImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.h,
                          left: 30.w,
                          child: SizedBox(
                            width: 80.w,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .distribute_your_property_properly,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
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
    );
  }
}
