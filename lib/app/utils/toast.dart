import 'package:alabtechproject/app/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

bool _isToastShowing = false;

void failurtoast({title, duration = 2, bool? isSuccess = false}) {
  FocusManager.instance.primaryFocus?.unfocus();

  HapticFeedback.lightImpact();
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  } else {
    Get.showSnackbar(
      GetSnackBar(
        icon: isSuccess == true
            ? const Icon(
                Icons.done,
                size: 18,
                color: Colors.white,
              )
            : const Icon(
                Icons.warning_amber_outlined,
                size: 18,
                color: Colors.white,
              ),
        backgroundColor: isSuccess == true ? Colors.green : Colors.red,
        message: title != '' ? title : 'Something went wrong',
        duration: Duration(seconds: duration),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        isDismissible: true,
        dismissDirection: DismissDirection.down,
      ),
    );
  }
}

void successtoast({title, duration = 2}) {
  FocusManager.instance.primaryFocus?.unfocus();

  Get.showSnackbar(
    GetSnackBar(
      icon: const Icon(
        Icons.done,
        size: 18,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
      message: title != '' ? title : 'Something went wrong',
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.endToStart,
    ),
  );
}

void toast(BuildContext context, {String? title, int duration = 2, Color? backgroundColor}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          width: Responsive.width * 90,
          content: Container(
            height: Responsive.height * 3,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(color: backgroundColor == const Color(0xFFFFDD11) ? Colors.black : Colors.white),
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      )
      .closed
      .then((reason) {
    _isToastShowing = false;
  });
}
