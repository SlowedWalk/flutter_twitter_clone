import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';
import '../widgets/auth_field.dart';
import '../../../theme/theme.dart';

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

  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleSignUp() {
    loading = true;
    ref.read(authControllerProvider.notifier).signUp(
      email: emailController.text,
      password: passwordController.text,
      context: context);
    loading = false;
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
                  ),
                  const SizedBox(height: 25),
                  // textfeild 1
                  AuthField(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 40),
                  // button
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmBtn(
                      onTap: handleSignUp,
                      label: "Sign Up",
                    ),
                  ),
                  // textspan
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                          fontSize: 16, color: Pallet.whiteColor),
                      children: [
                        TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                            color: Pallet.blueColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
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
