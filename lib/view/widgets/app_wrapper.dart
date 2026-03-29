import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:al_wasyeah/utils/app_image.dart';

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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backImg),
          fit: BoxFit.cover,
        ),
      ),
      child: hasInternet ? widget.child : NoInternetWidget(),
    );
  }
}
