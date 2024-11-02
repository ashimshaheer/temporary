import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../../login/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checkingButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.splashLogo,
          height: Responsive.height * 100,
          fit: BoxFit.fill,
          width: Responsive.width * 100,
        ),
      ),
    );
  }

  Future<void> changeScreen(BuildContext context) async {
    final check = await checking();
    log(check.toString());
    await Future.delayed(
      const Duration(seconds: 4),
    );
    if (check) {
      // if (AppPref.isSignedIn == true) {
      // context.goNamed(AppRouter.tab);
      // } else {
      // context.goNamed(AppRouter.sliderScreen);
      // }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      // context.goNamed(AppRouter.noInternet);
    }
  }

  Future<bool> checking() async {
    checkingButton = true;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');
        checkingButton = false;
        return true;
      }
      checkingButton = false;
      return false;
    } on SocketException catch (_) {
      log('not connected');
      checkingButton = false;
      return false;
    }
  }

  @override
  initState() {
    super.initState();
    changeScreen(context);
  }
}
