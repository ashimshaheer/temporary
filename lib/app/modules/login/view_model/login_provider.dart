import 'dart:developer';

import 'package:alabtechproject/app/modules/home/view/home_screen.dart';
import 'package:alabtechproject/app/utils/preference.dart';
import 'package:flutter/material.dart';

import 'sarvice.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController? loginEmailController = TextEditingController();
  TextEditingController? loginPasswordController = TextEditingController();
  TextEditingController? signUpNameController = TextEditingController();
  TextEditingController? signUpEmailController = TextEditingController();
  TextEditingController? signUppasswordController = TextEditingController();

  bool loginpasswordVisibiliy = false;
  bool signUppasswordVisibiliy = false;
  bool signUpConfirmpasswordVisibiliy = false;

  bool isLogin = true;
  bool isSignup = true;
  String? userEmail;
  String? username;
  clearfnc() {
    loginEmailController?.clear();
    loginPasswordController?.clear();
    signUpNameController?.clear();
    signUpEmailController?.clear();
    signUppasswordController?.clear();
    notifyListeners();
  }

  void fetchUserData() async {
    Map<String, dynamic>? userDetails = await AuthService().getUserDetails();

    // Extract email and username from userDetails map
    userEmail = userDetails?['email'];
    username = userDetails?['name'];

    print("Email: $userEmail");
    print("Username: $username");
  }

  isLoginOrSignupFnc({required bool thisLogin, required bool thisSignUP}) {
    isLogin = thisLogin;
    isSignup = thisSignUP;
    notifyListeners();
  }

  loginFnc({required BuildContext context}) async {
    try {
      log('this is the login');
      final message = await AuthService().login(
        email: loginEmailController?.text ?? '',
        password: loginPasswordController?.text ?? '',
      );
      if (message!.contains('Success')) {
        fetchUserData();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        clearfnc();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(message),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(message),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  loginPasswordFnc() {
    loginpasswordVisibiliy = !loginpasswordVisibiliy;
    notifyListeners();
  }

  signUpConfirmPasswordFnc() {
    signUpConfirmpasswordVisibiliy = !signUpConfirmpasswordVisibiliy;
    notifyListeners();
  }

  signUpPasswordFnc() {
    signUppasswordVisibiliy = !signUppasswordVisibiliy;
    notifyListeners();
  }

  sinupFnc({required BuildContext context}) async {
    try {
      final message = await AuthService().registration(
          email: signUpEmailController?.text ?? '',
          password: signUppasswordController?.text ?? '',
          name: signUpNameController?.text ?? '');
      if (message!.contains('Success')) {
        fetchUserData();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
        AppPref.isSignedIn = true;
        clearfnc();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(message),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(message),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    } finally {
      notifyListeners();
    }
  }
}
