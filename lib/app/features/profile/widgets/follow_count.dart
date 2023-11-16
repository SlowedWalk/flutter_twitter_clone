import 'package:flutter/material.dart';
import 'package:twitter_clone/app/theme/pallet.dart';
 class FollowCount extends StatelessWidget {
   final int count;
   final String text;
   const FollowCount({super.key, required this.count, required this.text});

   @override
   Widget build(BuildContext context) {
     double fontSize = 18;
     return Row(
       children: [
         Text(
           '$count',
           style: TextStyle(
             color: Pallet.whiteColor,
             fontSize: fontSize,
             fontWeight: FontWeight.bold
           ),
         ),
         const SizedBox(width: 3),
         Text(
           text,
           style: TextStyle(
             color: Pallet.greyColor,
             fontSize: fontSize
           ),
         )
       ],
     );
   }
 }
