import 'package:al_wasiyyath/app/view/notification/controller/notification_controller.dart';
import 'package:al_wasiyyath/app/view/home/controller/home_controller.dart';
import 'package:al_wasiyyath/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasiyyath/app/core/route/route_names.dart';
import 'package:al_wasiyyath/app/core/utils/api_constants.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/utils/app_icons.dart';
import 'package:al_wasiyyath/app/core/utils/app_image.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  Widget _notificationIconOnly(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: IconButton(
        icon: Icon(
          Icons.notifications_outlined,
          size: 26,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
        onPressed: () {
          Get.toNamed(
            RouteName.notificationPage,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 12.w,
          title: GestureDetector(
            onTap: () =>
                Get.toNamed(RouteName.menuPage, preventDuplicates: false),
            child: Obx(() {
              final isProfileLoading =
                  profileController.profileModel.value.userProfile == null;
              final user = profileController.profileModel.value.userProfile;
              final fullName =
                  "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim();

              return Skeletonizer(
                enabled: isProfileLoading,
                effect: ShimmerEffect(
                  baseColor:
                      isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  highlightColor:
                      isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                ),
                containersColor:
                    isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                child: Row(
                  children: [
                    user?.profilePictureUrl != null
                        ? CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                "${ApiConstants.imageUrl + "${user?.profilePictureUrl}"}"),
                            backgroundColor: isDark
                                ? const Color(0xFF2C3E35)
                                : Colors.grey[200],
                          )
                        : CircleAvatar(
                            radius: 18,
                            child: Icon(
                              Icons.person,
                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                            backgroundColor: isDark
                                ? const Color(0xFF2C3E35)
                                : Colors.grey[200],
                          ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName.isNotEmpty ? fullName : "User Name",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xff1A1A1A),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.welcome_back,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark
                                  ? const Color(0xff94A3B8)
                                  : const Color(0xff6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
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
                          color: isDark
                              ? (unreadCount > 0
                                  ? Colors.white
                                  : Colors.grey.shade400)
                              : (unreadCount > 0
                                  ? Colors.black
                                  : Colors.grey.shade700),
                        ),
                        splashRadius: 22,
                        onPressed: () {
                          Get.toNamed(
                            RouteName.notificationPage,
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
                                color: isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.redAccent.withValues(alpha: 0.4),
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

              /// When loading → show skeletonized notification icon + badge
              onLoading: Skeletonizer(
                enabled: true,
                effect: ShimmerEffect(
                  baseColor:
                      isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  highlightColor:
                      isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          size: 26,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
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
                              color: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "1",
                              style: TextStyle(
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
                ),
              ),
              onEmpty: _notificationIconOnly(context),
              onError: (_) => _notificationIconOnly(context),
            ),
            SizedBox(width: 8.h), // Space between the image and text
          ],
        ),
      ),
      body: Container(
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

                ///=======================Explore your \n Wasiyyah==========================

                InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.wasyyahPage,
                        preventDuplicates: false);
                  },
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF2C3E35)
                            : AppColors.primaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          AppIcons.exploreWasyea,
                          width: 80.w,
                          height: 80.h,
                          colorFilter: isDark
                              ? const ColorFilter.mode(
                                  Color(0xFF4ADE80), BlendMode.srcIn)
                              : null,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .explore_your_wasiyyah,
                          fontsize: 18.sp,
                          color: isDark
                              ? const Color(0xFF4ADE80)
                              : AppColors.primaryColor,
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
                          Get.toNamed(RouteName.witnessesPage,
                              preventDuplicates: false);
                        },
                        child: Container(
                          height: 100.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2C3E35)
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                AppIcons.witness,
                                width: 50.w,
                                height: 50.h,
                                colorFilter: isDark
                                    ? const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn)
                                    : null,
                              ),
                              CustomText(
                                text: AppLocalizations.of(context)!.witness,
                                fontsize: 18.sp,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textColor4E4E4E,
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
                          Get.toNamed(RouteName.nomineesPage,
                              preventDuplicates: false);
                        },
                        child: Container(
                          height: 100.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2C3E35)
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                AppIcons.nominee,
                                width: 40.w,
                                height: 40.h,
                                colorFilter: isDark
                                    ? const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn)
                                    : null,
                              ),
                              CustomText(
                                text: AppLocalizations.of(context)!.nominee,
                                fontsize: 18.sp,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textColor4E4E4E,
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
                      color: isDark
                          ? const Color(0xFF1E1E1E).withValues(alpha: 0.9)
                          : Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF2C3E35)
                            : AppColors.primaryColor.withValues(alpha: 0.3),
                      ),
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
                            color: isDark
                                ? AppColors.primaryColor.withValues(alpha: 0.2)
                                : AppColors.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryColor
                                  .withValues(alpha: isDark ? 0.35 : 0.2),
                            ),
                          ),
                          child: Obx(
                            () => CustomText(
                              text: controller.currentTime.value,
                              fontsize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color(0xFF4ADE80)
                                  : AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: AppLocalizations.of(context)!.current_time,
                          fontsize: 12.sp,
                          color: isDark ? const Color(0xff94A3B8) : Colors.grey,
                        ),

                        // Sunrise & Sunset Column
                        Obx(
                          () => Skeletonizer(
                            enabled: controller.salatTimeStatus.value.isLoading,
                            effect: ShimmerEffect(
                              baseColor: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              highlightColor: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade100,
                            ),
                            containersColor: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 4.h),
                                // Sunrise
                                Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.wb_sunny,
                                            color: Colors.orange, size: 20.sp),
                                        SizedBox(width: 4.w),
                                        Flexible(
                                          child: CustomText(
                                            text: controller.formatTime(
                                                controller.salatTimeModel.value
                                                        ?.sunrise ??
                                                    "06:00"),
                                            fontsize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      text: AppLocalizations.of(context)!
                                          .sunrise_time,
                                      fontsize: 12.sp,
                                      color: isDark
                                          ? const Color(0xff94A3B8)
                                          : Colors.grey,
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
                                            color: isDark
                                                ? const Color(0xFF93C5FD)
                                                : Colors.blueGrey,
                                            size: 20.sp),
                                        SizedBox(width: 4.w),
                                        Flexible(
                                          child: CustomText(
                                            text: controller.formatTime(
                                                controller.salatTimeModel.value
                                                        ?.sunset ??
                                                    "18:00"),
                                            fontsize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      text: AppLocalizations.of(context)!
                                          .sunset_time,
                                      fontsize: 12.sp,
                                      color: isDark
                                          ? const Color(0xff94A3B8)
                                          : Colors.grey,
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
                  child: Text(
                    AppLocalizations.of(context)!.prayer_times,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? const Color(0xFF4ADE80) : Colors.green[700],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Obx(() {
                  if (controller.salatTimeStatus.value.isError) {
                    return ErrorWidget(Exception(
                        "${controller.salatTimeStatus.value.errorMessage}"));
                  }

                  final isLoading = controller.salatTimeStatus.value.isLoading;

                  return SizedBox(
                    height: 220.h,
                    child: Skeletonizer(
                      enabled: isLoading,
                      effect: ShimmerEffect(
                        baseColor: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        highlightColor:
                            isDark ? Colors.grey.shade700 : Colors.grey.shade50,
                        duration: const Duration(milliseconds: 1500),
                      ),
                      containersColor:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                      child: ListView.builder(
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: isLoading
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                        itemCount:
                            isLoading ? 4 : controller.prayerTimes.length,
                        itemBuilder: (context, index) {
                          if (isLoading) {
                            return Container(
                              width: 0.6.sw,
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF2C3E35)
                                      : Colors.grey.shade200,
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? Colors.black.withValues(alpha: 0.3)
                                        : Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Top Prayer Status badge placeholder
                                    Container(
                                      width: 110.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.grey.shade700
                                            : Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    // Countdown timer placeholder
                                    Container(
                                      width: 80.w,
                                      height: 18.h,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.grey.shade700
                                            : Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                    ),
                                    const Spacer(),
                                    // Bottom right: Prayer Name, Time & Notification Switch
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 75.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Container(
                                            width: 60.w,
                                            height: 18.h,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            height: 26.h,
                                            width: 48.w,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(14.r),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          final name =
                              controller.prayerTimes.keys.elementAt(index);
                          final time = controller.prayerTimes[name]!;
                          final isCurrent =
                              name == controller.currentPrayer.value;

                          final prayerNames =
                              controller.prayerTimes.keys.toList();
                          final currentIndex = prayerNames
                              .indexOf(controller.currentPrayer.value);
                          final pIndex = prayerNames.indexOf(name);

                          LinearGradient gradient;
                          LinearGradient borderGradient;
                          double borderWidth = 1.0;
                          if (isCurrent) {
                            gradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF1E382B),
                                      Color(0xFF172D22),
                                      Color(0xFF102118),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFAFAFA),
                                      Color(0xFFF1F8F2),
                                      Color(0xFFDFF5DD),
                                      Color(0xFFC8E6C9),
                                      Color(0xFFA5D6A7),
                                      Color(0xFF81C784),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  );

                            borderGradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF4ADE80),
                                      Color(0xFF22C55E),
                                      Color(0xFF16A34A),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFF81C784),
                                      Color(0xFFA5D6A7),
                                      Color(0xFFC8E6C9),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  );
                          } else if (pIndex < currentIndex &&
                              currentIndex != -1) {
                            gradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF262626),
                                      Color(0xFF1E1E1E),
                                      Color(0xFF171717),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFAFAFA),
                                      Color(0xFFF5F5F5),
                                      Color(0xFFEDEDED),
                                      Color(0xFFE0E0E0),
                                      Color(0xFFBDBDBD),
                                      Color(0xFF9E9E9E),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  );

                            borderGradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF525252),
                                      Color(0xFF404040),
                                      Color(0xFF262626),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFF9E9E9E),
                                      Color(0xFFBDBDBD),
                                      Color(0xFFE0E0E0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  );
                          } else {
                            gradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF332514),
                                      Color(0xFF281D0E),
                                      Color(0xFF1F160A),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFBF0),
                                      Color(0xFFFFF8E1),
                                      Color(0xFFFFF3C4),
                                      Color(0xFFFFECB3),
                                      Color(0xFFFFD54F),
                                      Color(0xFFFFB300),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  );

                            borderGradient = isDark
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFBBF24),
                                      Color(0xFFF59E0B),
                                      Color(0xFFD97706),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFFFB300),
                                      Color(0xFFFFD54F),
                                      Color(0xFFFFECB3),
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
                                    gradient: borderGradient,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),

                                // 2. Inner Card with Padding for Border Effect
                                Container(
                                  margin: EdgeInsets.all(borderWidth),
                                  decoration: BoxDecoration(
                                    gradient: gradient,
                                    borderRadius: BorderRadius.circular(
                                        16.0 - borderWidth),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                            alpha: isDark ? 0.3 : 0.05),
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
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                          ),
                                          child: Image.asset(
                                            isDark
                                                ? AppImages.mosjidDarkIcon
                                                : AppImages.mosjidIcon,
                                            height: 150.h,
                                            width: 150.w,
                                            fit: BoxFit.contain,
                                            // color: isDark
                                            //     ? Colors.white.withValues(alpha: 0.12)
                                            //     : null,
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
                                                color: isDark
                                                    ? (isCurrent
                                                        ? const Color(
                                                            0xFF4ADE80)
                                                        : Colors.white)
                                                    : Colors.black,
                                              ),
                                            ),
                                            if (isCurrent)
                                              Obx(
                                                () => Text(
                                                  controller
                                                      .remainingTimeStr.value,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark
                                                        ? const Color(
                                                            0xFF4ADE80)
                                                        : Colors.black,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ),
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
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
                                                            : name == "Maghrib"
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .maghrib
                                                                : name == "Isha"
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
                                                      color: isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    controller.formatTime(time),
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  SizedBox(
                                                    height: 30.h,
                                                    width: 50.w,
                                                    child: FittedBox(
                                                      fit: BoxFit.fill,
                                                      child: Switch(
                                                        value: isCurrent,
                                                        activeThumbColor: Colors
                                                            .greenAccent[400],
                                                        activeTrackColor: isDark
                                                            ? Colors
                                                                .green.shade900
                                                            : null,
                                                        inactiveThumbColor:
                                                            isDark
                                                                ? Colors.grey
                                                                    .shade400
                                                                : null,
                                                        inactiveTrackColor:
                                                            isDark
                                                                ? Colors.grey
                                                                    .shade800
                                                                : null,
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
                    Get.toNamed(RouteName.zakatCalculatorPage,
                        preventDuplicates: false);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 220.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: isDark
                              ? Border.all(color: const Color(0xFF2C3E35))
                              : null,
                          boxShadow: [
                            if (isDark)
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                          image: const DecorationImage(
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
                            color: const Color(0xFF2F5ADF),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70.h,
                        right: 40.w,
                        child: SizedBox(
                          width: 60.w,
                          child: Text(
                            AppLocalizations.of(context)!.calculate_your_zakat,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
                    Get.toNamed(RouteName.propertyDistributionPage,
                        preventDuplicates: false);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: isDark
                              ? Border.all(color: const Color(0xFF2C3E35))
                              : null,
                          boxShadow: [
                            if (isDark)
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage(
                                AppImages.distribureYourPropertyProperlyImage),
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
                              fontWeight: FontWeight.w600,
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
    );
  }
}
