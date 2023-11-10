import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/loading_page.dart';
import 'package:twitter_clone/app/common/rounded_sm_btn.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/auth/views/sing_up_view.dart';
import 'package:twitter_clone/app/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: appbar,
        body: isLoading
            ? const Loader()
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // textfeild 1
                        AuthField(
                          controller: emailController,
                          hintText: 'Email',
                          inputType: 'email',
                        ),
                        const SizedBox(height: 25),
                        // textfeild 1
                        AuthField(
                          controller: passwordController,
                          hintText: 'Password',
                          inputType: 'password',
                        ),
                        const SizedBox(height: 40),
                        // button
                        Align(
                          alignment: Alignment.topRight,
                          child: RoundedSmBtn(
                            onTap: handleLogin,
                            label: "Login",
                          ),
                        ),
                        const SizedBox(height: 40),
                        RichText(
                            text: TextSpan(
                                text: "Don't have an account?",
                                style: const TextStyle(
                                    fontSize: 16, color: Pallet.whiteColor),
                                children: [
                              TextSpan(
                                  text: ' Sign up',
                                  style: const TextStyle(
                                    color: Pallet.blueColor,
                                    fontSize: 16,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context, SignUpView.route());
                                    })
                            ]))
                      ],
                    ),
                  ),
                ),
              ));
  }
}
