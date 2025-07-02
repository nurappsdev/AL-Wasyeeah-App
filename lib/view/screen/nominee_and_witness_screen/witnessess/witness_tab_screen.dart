
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

import '../../../widgets/widgets.dart';
import '../../no_internet_screen.dart';
import '../../screen.dart';

class WitnessTabScreen extends StatefulWidget {
  const WitnessTabScreen({super.key});

  @override
  State<WitnessTabScreen> createState() => _WitnessTabScreenState();
}

class _WitnessTabScreenState extends State<WitnessTabScreen>
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
        appBar: AppBar(title: CustomText(text: "Witness".tr,fontsize: 20.sp,),),
        body: Column(
          children: [
            const SizedBox(height: 10),
            _buildCustomTabBar(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children:  [
                  WitnessesYouScreen(tabController: tabController),
                  YourWitnessScreen(tabController: tabController),
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
          Tab(text:  'Your Witness'.tr,),
          Tab(text: 'I’m the witness'.tr,),
        ],
      ),
    );
  }
}
