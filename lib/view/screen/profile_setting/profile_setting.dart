import 'package:al_wasyeah/view/screen/profile_setting/profile_screen1.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'profile_screen2.dart';

class StepNavigationWithPageView extends StatefulWidget {
  @override
  _StepNavigationWithPageViewState createState() =>
      _StepNavigationWithPageViewState();
}

class _StepNavigationWithPageViewState
    extends State<StepNavigationWithPageView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Navigate to a specific page based on step
  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:CustomText(text: "Profile Settings",fontWeight: FontWeight.w600,fontsize: 20.sp,),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Step Indicator
            Padding(
              padding: const EdgeInsets.only(left: 26.0,top: 20,bottom: 20,),
              child: Row(
                children: List.generate(5, (index) {
                  bool isCompleted = index < _currentStep;
                  bool isActive = index == _currentStep;

                  return Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => _onStepTapped(index),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isCompleted || isActive
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        if (index < 4)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: isCompleted
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // PageView for the screens
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  ProfileScreen1(),
                  ProfileScreen1(),
                  ProfileScreen1(),
                  ProfileScreen1(),
                  ProfileScreen2(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    home: StepNavigationWithPageView(),
  ));
}
