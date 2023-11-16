import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/app/features/profile/views/edit_profile_view.dart';
import 'package:twitter_clone/app/features/profile/widgets/follow_count.dart';
import 'package:twitter_clone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/app/features/tweet/widget/tweet_card.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/model/user_model.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class UserProfile extends ConsumerWidget {
  final UserModel user;
  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return currentUser == null
        ? const Center(child: CircularProgressIndicator())
        : NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 150,
                floating: true,
                snap: true,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: user.bannerPic.isEmpty
                        ? Container(color: Pallet.blueColor)
                        : Image.network(user.bannerPic, fit: BoxFit.fitHeight)
                    ),
                    Positioned(
                      bottom: 10,
                      left: 24,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 35,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.all(20),
                      child: OutlinedButton(
                          onPressed: () {
                            if(currentUser.uid == user.uid) {
                              // edit profile
                              Navigator.push(context, EditProfileView.route());
                            } else {
                              ref.read(userProfileControllerProvider.notifier).followUser(
                                  user: user,
                                  context: context,
                                  currentUser: currentUser
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                             side: const BorderSide(
                               color: Pallet.whiteColor,
                                width: 1.5
                             )
                          ),
                          child: Text(
                            currentUser.uid == user.uid
                                ? "Edit profile"
                                : currentUser.followers.contains(user.uid) ? "Unfollow" : "Follow",
                              style: const TextStyle(
                                  color: Pallet.whiteColor
                              )
                          )
                      ),
                    )
                  ],
                ),
              ),
              SliverPadding(
                  padding: const EdgeInsets.all(8),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Pallet.greyColor,
                        ),
                      ),
                      Text(
                        user.bio,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FollowCount(
                              count: user.followers.length,
                              text: 'Followers'
                          ),
                          const SizedBox(width: 15),
                          FollowCount(
                              count: user.following.length,
                              text: 'Following'
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Divider(color: Pallet.whiteColor),
                    ],
                  ),
                ),
              )
            ];
        } ,
        body: ref.watch(getUserTweetsProvider(user.uid)).when(
            data: (tweets) {
              return ref.watch(getLatestTweetProvider).when(
                  data: (data) {
                    final latestTweet = Tweet.fromMap(data.payload);
                    bool isTweetAlreadyPresent = false;
                    for(final tweetModel in tweets) {
                      if(tweetModel.id == latestTweet.id) {
                        isTweetAlreadyPresent = true;
                        break;
                      }
                    }
                    if(!isTweetAlreadyPresent) {
                      if (data.events.contains(
                          'databases.*.collections.${AppWriteConstants.tweetsCollectionId}.documents.*.create')) {
                        tweets.insert(0, Tweet.fromMap(data.payload));
                      } else if (data.events.contains(
                          'databases.*.collections.${AppWriteConstants.tweetsCollectionId}.documents.*.update')) {
                        final startingPoint =
                        data.events[0].lastIndexOf('documents.');
                        final endPoint =
                        data.events[0].lastIndexOf('.update');

                        final tweetId = data.events[0]
                            .substring(startingPoint + 10, endPoint);

                        var tweet = tweets
                            .where((element) => element.id == tweetId)
                            .first;
                        final tweetIndex = tweets.indexOf(tweet);
                        tweets
                            .removeWhere((element) => element.id == tweetId);
                        tweet = Tweet.fromMap(data.payload);
                        tweets.insert(tweetIndex, tweet);
                      }
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: tweets.length,
                          itemBuilder: (BuildContext context, int index) {
                            final tweet = tweets[index];
                            return TweetCard(tweet: tweet);
                          }),
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: tweets.length,
                          itemBuilder: (BuildContext context, int index) {
                            final tweet = tweets[index];
                            return TweetCard(tweet: tweet);
                          }),
                    );
                  });
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Center(child: CircularProgressIndicator())
        ),
    );
  }
}