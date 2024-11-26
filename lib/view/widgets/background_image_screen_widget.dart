
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget child;

 const BackgroundImageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: Get.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backImg),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
