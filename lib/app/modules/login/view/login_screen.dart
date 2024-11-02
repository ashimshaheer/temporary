import 'package:alabtechproject/app/modules/login/view_model/login_provider.dart';
import 'package:alabtechproject/app/utils/app_images.dart';
import 'package:alabtechproject/app/utils/common_widgets.dart';
import 'package:alabtechproject/app/utils/extentions.dart';
import 'package:alabtechproject/app/utils/size_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class LoginWidgets extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginWidgets({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, obj, _) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            ComonTextfieldWidgets(
                controller: obj.loginEmailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black45,
                ), // Emai
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                }),
            SizeBoxH(Responsive.height * 2),
            ComonTextfieldWidgets(
              controller: obj.loginPasswordController,
              keyboardType: TextInputType.visiblePassword,
              hintText: 'password',
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black45,
              ), // Email icon as prefix
              obscureText: obj.loginpasswordVisibiliy,
              suffixIcon: GestureDetector(
                onTap: () => obj.loginPasswordFnc(),
                child: Icon(
                  obj.loginpasswordVisibiliy ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black45,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ),
      );
    });
  }
}

class SignUpOrLoginButton extends StatelessWidget {
  const SignUpOrLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 50,
      decoration: const BoxDecoration(
          color: Color(0xFFFF6600),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Color(0xFFFF6600),
                blurStyle: BlurStyle.inner,
                offset: Offset(1, 1),
                spreadRadius: 0.1)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: const CommonTextWidget(
        color: Colors.white,
        text: 'Enter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class SignUpWidgets extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SignUpWidgets({super.key, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, obj, _) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            ComonTextfieldWidgets(
              keyboardType: TextInputType.name,
              controller: obj.signUpNameController,
              hintText: 'Name',
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.black45,
              ), // Email icon as prefix
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                }
                return null;
              },
            ),
            SizeBoxH(Responsive.height * 2),
            ComonTextfieldWidgets(
              keyboardType: TextInputType.emailAddress,
              controller: obj.signUpEmailController,
              hintText: 'Email',
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.black45,
              ), // Email icon as prefix
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizeBoxH(Responsive.height * 2),
            ComonTextfieldWidgets(
              keyboardType: TextInputType.visiblePassword,
              controller: obj.signUppasswordController,
              hintText: 'password',
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black45,
              ), // Email icon as prefix
              obscureText: obj.signUppasswordVisibiliy,
              suffixIcon: GestureDetector(
                onTap: () => obj.signUpPasswordFnc(),
                child: Icon(
                  obj.signUppasswordVisibiliy ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black45,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizeBoxH(Responsive.height * 2),
            const CommonTextWidget(color: Colors.black, text: 'OR'),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.googleImage,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12),
                    const CommonTextWidget(
                      text: 'Sign in with Google',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: Responsive.width * 100,
        height: Responsive.height * 100,
        child: Stack(
          children: [
            Container(
              width: Responsive.width * 100,
              height: Responsive.height * 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6600),
              ),
              child: Column(
                children: [
                  SizeBoxH(Responsive.height * 3),
                  Image.asset(
                    AppImages.loginImage,
                    width: Responsive.width * 55,
                    height: Responsive.height * 20,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Responsive.width * 100,
                height: Responsive.height * 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(Responsive.width * 100, 30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizeBoxH(Responsive.height * 13),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonTextWidget(
                          color: Colors.black45,
                          text: 'Forget password?',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    SizeBoxH(Responsive.height * 28),
                    SizeBoxH(Responsive.height * 2),
                    Consumer<LoginProvider>(builder: (context, obj, _) {
                      return InkWell(
                          onTap: () {
                            if (obj.isSignup) {
                              if (signUpFormKey.currentState?.validate() ?? false) {
                                obj.sinupFnc(context: context);
                              }
                            } else if (obj.isLogin) {
                              if (loginFormKey.currentState?.validate() ?? false) {
                                obj.loginFnc(context: context);
                              }
                            }
                          },
                          child: const SignUpOrLoginButton());
                    }),
                  ],
                ),
              ),
            ),
            Positioned(
              top: Responsive.height * 28,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Consumer<LoginProvider>(builder: (context, value, _) {
                      return SizedBox(
                        width: Responsive.width * 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                value.isLoginOrSignupFnc(thisLogin: true, thisSignUP: false);
                                value.clearfnc();
                              },
                              child: CommonTextWidget(
                                color: value.isLogin == false ? Colors.grey[300] ?? Colors.grey : Colors.white,
                                text: 'Login',
                                fontWeight: FontWeight.w800,
                                fontSize: 30,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.isLoginOrSignupFnc(thisLogin: false, thisSignUP: true);
                                value.clearfnc();
                              },
                              child: CommonTextWidget(
                                color: value.isSignup == false ? Colors.grey[300] ?? Colors.grey : Colors.white,
                                text: 'Sign Up',
                                fontWeight: FontWeight.w800,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizeBoxH(Responsive.height * 1),
                    Consumer<LoginProvider>(builder: (context, obj, _) {
                      return Container(
                          width: Responsive.width * 92,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.black,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(1, 1),
                                    spreadRadius: 0.1)
                              ]),
                          child: obj.isLogin == true && obj.isSignup == false
                              ? LoginWidgets(
                                  formKey: loginFormKey,
                                )
                              : SignUpWidgets(
                                  formKey: signUpFormKey,
                                ));
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Now it's safe to call provider functions that update state
      context.read<LoginProvider>().isLoginOrSignupFnc(thisLogin: true, thisSignUP: false);
    });
  }
}
