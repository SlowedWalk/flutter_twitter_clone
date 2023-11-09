import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/api/storage_api.dart';
import 'package:twitter_clone/app/api/tweet_api.dart';
import 'package:twitter_clone/app/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';

import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/model/user_model.dart';


final tweetControllerProvider = StateNotifierProvider.autoDispose<TweetController, bool>((ref) {
  return TweetController(
      ref: ref,
      tweetAPI: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider),
  );
});

final getTweetsProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(tweetControllerProvider.notifier).getTweets();
});

final getLatestTweetProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(tweetAPIProvider).getLatestTweet();
});

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;
  TweetController({required Ref ref, required TweetAPI tweetAPI, required StorageAPI storageAPI}):
        _ref = ref,
        _tweetAPI = tweetAPI,
        _storageAPI = storageAPI,
        super(false);

  Future<List<Tweet>> getTweets() async {
    final tweets = await _tweetAPI.getTweets();
    return tweets.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  void likeTweet(Tweet tweet, UserModel user) async {
    List<String> likes = tweet.likes;
    
    if(tweet.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }
    tweet = tweet.copyWith(likes: likes);

    final res = await _tweetAPI.likeTweet(tweet);

    res.fold((l) => null, (r) => null);
  }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context })
  {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter some text!');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
      );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context
  })
  async {
    state = true;
    final hashtags = _getHashtagFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImages(images);
    Tweet tweet = Tweet(
        uid: user.uid,
        text: text,
        hashtags: hashtags,
        link: link,
        imagesLinks: imageLinks,
        tweetType: TweetType.image,
        tweetedAt: DateTime.timestamp(),
        likes: const [],
        commentIds: const [],
        id: ID.unique(),
        reSharedCount: 0
    );

    final response = await _tweetAPI.shareTweet(tweet);
    state = false;
    response.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void _shareTextTweet({
    required String text,
    required BuildContext context
  })
  async {
    state = true;
    final hashtags = _getHashtagFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Tweet tweet = Tweet(
        uid: user.uid,
        text: text,
        hashtags: hashtags,
        link: link,
        imagesLinks: const [],
        tweetType: TweetType.text,
        tweetedAt: DateTime.timestamp(),
        likes: const [],
        commentIds: const [],
        id: ID.unique(),
        reSharedCount: 0
    );

    final response = await _tweetAPI.shareTweet(tweet);
    state = false;
    response.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for(String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for(String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }

}

