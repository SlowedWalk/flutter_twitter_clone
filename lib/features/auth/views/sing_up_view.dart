import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_feild.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleSignUp() {
    ref.read(authControllerProvider.notifier)
        .signUp(email: emailController.text, password: passwordController.text, context: context);
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
                      onTap: handleSignUp,
                      label: "Login",
                    ),
                  ),
                  // textspan
                  const SizedBox(height: 40),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(fontSize: 16, color: Pallete.whiteColor),
                          children: [
                            TextSpan(
                                text: ' Login',
                                style: const TextStyle(
                                  color: Pallete.blueColor,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(context, LoginView.route());
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
