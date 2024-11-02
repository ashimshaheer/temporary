import 'dart:developer';

import 'package:alabtechproject/app/modules/login/view_model/sarvice.dart';
import 'package:flutter/material.dart';

import '../../../utils/preference.dart';
import '../../login/view/login_screen.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController? searchController = TextEditingController();
  bool isCheckBox = false;
  List tipList = ['20', '30', '40', '50'];
  int tipIndex = -1;
  isCheckBoxFnc() {
    isCheckBox = !isCheckBox;
    notifyListeners();
  }

  signOut({required BuildContext context}) async {
    try {
      final message = await AuthService().signOut();
      if (message!.contains('Success')) {
        log('aaaaaaaaaaaaaa');

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
        AppPref.isSignedIn = false;
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
    } finally {
      notifyListeners();
    }
  }

  tipIndexFnc({required int index}) {
    tipIndex = index;
    notifyListeners();
  }
}
