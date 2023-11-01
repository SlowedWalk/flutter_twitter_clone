import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/theme/theme.dart';
// import 'package:twitter_clone/features/explore/view/explore_view.dart';
// import 'package:twitter_clone/features/notifications/views/notification_view.dart';
// import 'package:twitter_clone/features/tweet/widgets/tweet_list.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  // static const List<Widget> bottomTabBarPages = [
  //   TweetList(),
  //   ExploreView(),
  //   NotificationView(),
  // ];
}