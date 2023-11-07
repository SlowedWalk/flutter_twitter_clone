import 'package:flutter/material.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class RoundedSmBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const RoundedSmBtn({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Pallet.whiteColor,
    this.textColor = Pallet.backgroundColor,
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
