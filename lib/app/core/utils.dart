import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(content, textAlign: TextAlign.center, style: const TextStyle(
          fontSize: 18,
        ),)
    ),
  );
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}