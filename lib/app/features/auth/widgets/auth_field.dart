import 'package:flutter/material.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String inputType;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.inputType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: inputType == 'password' ? true : false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallet.blueColor,
            width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
              color: Pallet.greyColor,
              width: 2
          ),
        ),
        contentPadding: const EdgeInsets.all(24),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18)
      ),
    );
  }
}
