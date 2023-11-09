import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetScreen());

  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __CreateTweetScreenState();
}

class __CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier)
        .shareTweet(
        images: images,
        text: tweetTextController.text,
        context: context
    );
    Navigator.pop(context);
  }

  void onPickImage() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
            icon: const Icon(Icons.close, size: 24)),
        actions: [
          RoundedSmBtn(
            onTap: shareTweet,
            label: 'Tweet',
            backgroundColor: Pallet.blueColor,
            textColor: Pallet.whiteColor,
          ),
        ],
      ),
      body: isLoading || currentUser == null
        ? const Loader()
        : SafeArea(
          child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.profilePic),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: tweetTextController,
                    style: const TextStyle(
                      color: Pallet.whiteColor,
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      hintText: "What's happening?",
                      hintStyle: TextStyle(
                          color: Pallet.greyColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                )
              ],
            ),
            if (images.isNotEmpty)
              CarouselSlider(
                items: images.map((file) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.file(file),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 400,
                  enableInfiniteScroll: false,
                )
              )
          ]),
        )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallet.greyColor.withOpacity(0.8),
              width: 0.3
            )
          )
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: GestureDetector(
                onTap: onPickImage,
                child: SvgPicture.asset(
                    AssetsConstants.galleryIcon)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(
                  AssetsConstants.gifIcon
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(
                  AssetsConstants.emojiIcon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
