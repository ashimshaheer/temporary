import 'package:alabtechproject/app/modules/home/view_model/home_provider.dart';
import 'package:alabtechproject/app/modules/onboard/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/modules/login/view_model/login_provider.dart';
import 'app/utils/extentions.dart';
import 'app/utils/preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => LoginProvider())),
        ChangeNotifierProvider(create: ((context) => HomeProvider())),
      ],
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                Responsive().init(constraints, orientation);
                return const MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  home: SplashScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}
