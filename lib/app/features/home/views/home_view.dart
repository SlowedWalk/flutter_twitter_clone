import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/constants.dart';
import '../../tweet/view/create_tweet_view.dart';
import '../../../theme/theme.dart';

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
        backgroundColor: Pallet.blueColor,
        child: const Icon(Icons.add, color: Pallet.whiteColor, size: 18,),
      ) : null,
      bottomNavigationBar: CupertinoTabBar(
        height: 70,
        backgroundColor: Pallet.backgroundColor,
        currentIndex: _pageIndex,
        onTap: onPageChanged,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              AssetsConstants.homeFilledIcon,
              colorFilter: _pageIndex == 0
                  ? const ColorFilter.mode(Pallet.blueColor, BlendMode.srcIn)
                  : const ColorFilter.mode(Pallet.whiteColor, BlendMode.srcIn),
            )
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              colorFilter: _pageIndex == 1
                  ? const ColorFilter.mode(Pallet.blueColor, BlendMode.srcIn)
                  : const ColorFilter.mode(Pallet.whiteColor, BlendMode.srcIn),
            )
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: SvgPicture.asset(
              AssetsConstants.notifFilledIcon,
              colorFilter: _pageIndex == 2
                  ? const ColorFilter.mode(Pallet.blueColor, BlendMode.srcIn)
                  : const ColorFilter.mode(Pallet.whiteColor, BlendMode.srcIn),
            )
          ),
        ],
      ),
    );
  }
}
