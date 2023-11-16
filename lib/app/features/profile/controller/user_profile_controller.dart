import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/api/storage_api.dart';
import 'package:twitter_clone/app/api/tweet_api.dart';
import 'package:twitter_clone/app/api/user_api.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/model/user_model.dart';


final userProfileControllerProvider = StateNotifierProvider<UserProfileController, bool>((ref) {
  return UserProfileController(
      tweetApi: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider),
      userAPI: ref.watch(userAPIProvider)
  );
});

final getUserTweetsProvider = FutureProvider.family((ref, String uid) async {
  final userProfileController = ref.watch(userProfileControllerProvider.notifier);
  return userProfileController.getUserTweets(uid);
});

final getLatestUserProfileDataProvider = StreamProvider((ref) {
  final userAPI = ref.watch(userAPIProvider);
  return userAPI.getLatestUserProfileData();
});

class UserProfileController extends StateNotifier<bool> {
  final TweetAPI _tweetApi;
  final StorageAPI _storageAPI;
  final UserAPI _userAPI;

  UserProfileController({
    required TweetAPI tweetApi,
    required StorageAPI storageAPI,
    required UserAPI userAPI,
  }) :
        _tweetApi = tweetApi,
        _storageAPI = storageAPI,
        _userAPI = userAPI,
        super(false);

  Future<List<Tweet>> getUserTweets(String uid) async {
    final users = await _tweetApi.getUserTweets(uid);
    return users.map((user) => Tweet.fromMap(user.data)).toList();
  }

  void updateUserProfile({
    required UserModel userModel,
    required BuildContext context,
    required File? bannerFile,
    required File? profileImageFile,
  }) async {
    state = true;
    if (bannerFile != null) {
      final bannerUrl = await _storageAPI.uploadImages([bannerFile]);
      userModel = userModel.copyWith(
        bannerPic: bannerUrl[0],
      );
    }

    if (profileImageFile != null) {
      final profileImageUrl = await _storageAPI.uploadImages([profileImageFile]);
      userModel = userModel.copyWith(
        profilePic: profileImageUrl[0],
      );
    }

    final res = await _userAPI.updateUserData(userModel);
    state = false;
    res.fold(
            (l) => showSnackBar(context, l.message),
            (r) => Navigator.pop(context)
    );
  }

  void followUser({
    required UserModel user,
    required BuildContext context,
    required UserModel currentUser,
}) async {
    if(currentUser.following.contains(user.uid)) {
      user.followers.remove(currentUser.uid);
      currentUser.following.remove(user.uid);
    } else {
      user.followers.add(currentUser.uid);
      currentUser.following.add(user.uid);
    }

    user = user.copyWith(followers: user.followers);
    currentUser = currentUser.copyWith(following: currentUser.following);

    final res = await _userAPI.followUser(user);
    res.fold(
            (l) => showSnackBar(context, l.message),
            (r) async {
              final res2 = await _userAPI.addToFollowing(currentUser);
              res2.fold(
                      (l) => showSnackBar(context, l.message),
                      (r) => null
              );
            }
    );
  }

}
