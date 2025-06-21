

import 'package:al_wasyeah/view/screen/nominee_and_witness_screen/nominee/nomineeted_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

import '../../../widgets/widgets.dart';
import '../../no_internet_screen.dart';
import '../../screen.dart';

// class NomineeTabScreen extends StatefulWidget {
//   const NomineeTabScreen({super.key});
//
//   @override
//   State<NomineeTabScreen> createState() => _NomineeTabScreenState();
// }
//
// class _NomineeTabScreenState extends State<NomineeTabScreen> with SingleTickerProviderStateMixin{
//
//   late TabController tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this); // Initialize with 3 tabs
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:   AppBar(title: CustomText(text: "Nominee".tr,fontsize: 18.sp,),),
//         bottom: TabBar(
//           controller: tabController,
//           indicatorColor:AppColors.primaryColor,
//           unselectedLabelColor: Colors.black54,
//           labelStyle:  TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w600,fontSize: 16.sp),
//           tabs: [
//             Tab(text: 'Your Nominee'.tr,),
//             Tab(text:  'Nominated You'.tr,),
//           ],
//         ),
//       ),
//       body:  TabBarView(
//           controller: tabController,
//           children:
//           [
//             NomineeScreen(tabController: tabController),
//             NomineetedYouScreen(tabController: tabController),
//           ]
//       ),
//     );
//
//   }
// }

import 'package:flutter/material.dart';

class NomineeTabScreen extends StatefulWidget {
  const NomineeTabScreen({super.key});

  @override
  State<NomineeTabScreen> createState() => _NomineeTabScreenState();
}

class _NomineeTabScreenState extends State<NomineeTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      child: Scaffold(
        appBar: AppBar(title: CustomText(text: "Nominee".tr,fontsize: 20.sp,),),
        body: Column(
          children: [
            const SizedBox(height: 10),
            _buildCustomTabBar(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children:  [
                  NomineeScreen(tabController: tabController),
                  NomineetedYouScreen(tabController: tabController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(6),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs:  [
          Tab(text: 'Your Nominee'.tr),
          Tab(text: 'Nominated You'.tr),
        ],
      ),
    );
  }
}
