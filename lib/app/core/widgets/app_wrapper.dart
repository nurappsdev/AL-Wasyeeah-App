import 'dart:async';
import 'package:wasiyyat/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:wasiyyat/app/core/utils/app_image.dart';
import 'package:get/get.dart';

import 'no_internet_widget.dart'; // if in separate file

class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  late StreamSubscription _subscription;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    checkInitialConnection();

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        setState(() => hasInternet = false);
      } else {
        setState(() => hasInternet = true);
      }
    });
  }

  Future<void> checkInitialConnection() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      bottom: true,
      child: Obx(() {
        final dark = isDarkMode();
        return Container(
          decoration: dark
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backImgDark),
                    fit: BoxFit.cover,
                  ),
                )
              : const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backImg),
                    fit: BoxFit.cover,
                  ),
                ),
          child: hasInternet
              ? Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: widget.child,
                )
              : NoInternetWidget(),
        );
      }),
    );
  }
}
