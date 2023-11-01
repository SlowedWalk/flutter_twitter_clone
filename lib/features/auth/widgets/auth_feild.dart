import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class AuthFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthFeild({
    super.key,
    required this.controller,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
              color: Pallete.greyColor,
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
