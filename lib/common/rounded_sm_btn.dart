import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class RoundedSmBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const RoundedSmBtn({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Pallete.whiteColor,
    this.textColor = Pallete.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      onPressed: onTap,
      label: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: backgroundColor,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),

    );
  }
}
