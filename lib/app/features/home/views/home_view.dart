import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/features/tweet/view/create_tweet_view.dart';
import 'package:twitter_clone/app/theme/pallete.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const HomeView()
  );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _pageIndex = 0;
  final appbar = UIConstants.appBar();

  void onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: IndexedStack(
        index: _pageIndex,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: _pageIndex == 0 ? FloatingActionButton(
        onPressed: onCreateTweet,
        backgroundColor: Pallete.blueColor,
        child: const Icon(Icons.add, color: Pallete.whiteColor, size: 18,),
      ) : null,
      bottomNavigationBar: CupertinoTabBar(
        height: 70,
        backgroundColor: Pallete.backgroundColor,
        currentIndex: _pageIndex,
        onTap: onPageChanged,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              AssetsConstants.homeFilledIcon,
              color: _pageIndex == 0 ? Pallete.blueColor : Pallete.whiteColor
            )
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: _pageIndex == 1 ? Pallete.blueColor : Pallete.whiteColor
            )
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: SvgPicture.asset(
              AssetsConstants.notifFilledIcon,
              color: _pageIndex == 2 ? Pallete.blueColor : Pallete.whiteColor
            )
          ),
        ],
      ),
    );
  }
}
