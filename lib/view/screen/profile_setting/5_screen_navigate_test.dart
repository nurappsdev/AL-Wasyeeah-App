

import 'package:al_wasyeah/view/screen/profile_setting/father_info_screen.dart' show FatherInfoScreen;
import 'package:flutter/material.dart';

import 'bank_info_screen.dart';
import 'family_info_screen.dart';
import 'present_address_screen.dart';
import 'profile_screen1.dart';

void main() {
  runApp(MaterialApp(home: MultiStepFormScreen()));
}

class MultiStepFormScreen extends StatefulWidget {
  @override
  _MultiStepFormScreenState createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _steps = [
    ProfileScreen1(),
    PresentAddressScreen(),
    FatherInfoScreen(),
    FamilyInfoScreen(),
    BankInfoScreen(),
  ];

  void _nextPage() {
    if (_currentIndex < _steps.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() => _currentIndex++);
    } else {
      print("🎉 Finished!");
      // Show dialog or navigate
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Success"),
          content: Text("All steps completed!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step ${_currentIndex + 1} of ${_steps.length}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: _steps,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: _prevPage,
                    child: Text("Back"),
                  ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentIndex == _steps.length - 1 ? "Finish" : "Next"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
