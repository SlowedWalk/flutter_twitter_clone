import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/app/features/tweet/widget/tweet_card.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
      data: (tweets) {
        return ref.watch(getLatestTweetProvider).when(
            data: (data) {
              if (data.events.contains(
                  'databases.*.collections.${AppWriteConstants
                      .tweetsCollectionId}.documents.*.create'
              )) {
                tweets.insert(0, Tweet.fromMap(data.payload));
              }

              return ListView.builder(
                  itemCount: tweets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  }
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () {
              return ListView.builder(
                  itemCount: tweets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  }
              );
            }
        );
      },
      error: (error, stackTrace) => ErrorText(error: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

