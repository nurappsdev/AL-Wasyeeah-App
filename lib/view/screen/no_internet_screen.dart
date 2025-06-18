import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async';

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(); // loops forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget animatedEye() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final angle = _controller.value * 2 * math.pi;
            final radius = 20.0;

            final dx = math.cos(angle) * radius;
            final dy = math.sin(angle) * radius;

            return Transform.translate(
              offset: Offset(dx, dy),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Eye Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                animatedEye(),
                SizedBox(width: 30),
                animatedEye(),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Looks Like You're Lost",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey),
              ),
              onPressed: () {
                // Try rechecking connection
                setState(() {}); // trigger rebuild
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}



class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
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
    return hasInternet ? widget.child : NoInternetScreen();
  }
}

