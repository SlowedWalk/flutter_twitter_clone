import 'package:flutter/material.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({
    super.key, required this.text
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    text.split(' ').forEach((element) {
      if(element.startsWith('#')) {
        textSpans.add(TextSpan(
          text: '$element ',
          style: const TextStyle(
            color: Pallet.blueColor,
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
        ));
      } else if(element.startsWith('www.') || element.startsWith('https://')) {
        textSpans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
                color: Pallet.blueColor,
                fontSize: 16,
            )
        ));
      } else {
        textSpans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
                fontSize: 16,
              color: Pallet.whiteColor
            )
        ));
      }
    });
    return RichText(
        text: TextSpan(
            children: textSpans
        )
    );
  }
}
