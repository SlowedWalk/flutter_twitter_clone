import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_sm_btn.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/views/sing_up_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_feild.dart';
import 'package:twitter_clone/theme/theme.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // textfeild 1
                  AuthFeild(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 25),
                  // textfeild 1
                  AuthFeild(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 40),
                  // button
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmBtn(
                      onTap: () {
                        final snackBar = SnackBar(
                          content: const Text('Yay! A SnackBar!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      label: "Login",
                    ),
                  ),
                  // textspan
                  const SizedBox(height: 40),
                  RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Pallete.whiteColor
                          ),
                          children: [
                            TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(
                                    color: Pallete.blueColor,
                                    fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(context, SignUpView.route());
                                }
                            )
                          ]
                      )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
