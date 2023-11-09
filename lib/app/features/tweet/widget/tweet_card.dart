import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/assets_constants.dart';
import 'package:twitter_clone/app/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/tweet/widget/carousel_image.dart';
import 'package:twitter_clone/app/features/tweet/widget/hashtag_text.dart';
import 'package:twitter_clone/app/features/tweet/widget/tweet_icon_btn.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
      data: (user) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 28,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TODO: retweet
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: Text(
                                user.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                              ),
                            ),
                            Text(
                                '@${user.username} . ${timeago.format(
                                    tweet.tweetedAt,
                                    locale: 'en_short'
                                )}',
                                style: const TextStyle(
                                    color: Pallet.greyColor,
                                    fontSize: 16
                                )
                            ),
                          ],
                        ),
                        // replied to
                        HashtagText(text: tweet.text),
                        if(tweet.tweetType == TweetType.image)
                          CarouselImage(imageLinks: tweet.imagesLinks),
                        if(tweet.link.isNotEmpty) ... [
                          const SizedBox(height: 4),
                          AnyLinkPreview(
                            link: 'https://${tweet.link}',
                            displayDirection: UIDirection.uiDirectionHorizontal,
                            headers: const {"Access-Control-Allow-Origin": "*"},
                          )
                        ],
                        Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TweetIconBtn(
                                  pathName: AssetsConstants.viewsIcon,
                                  text: (
                                    tweet.commentIds.length +
                                    tweet.reSharedCount.bitLength +
                                    tweet.likes.length)
                                  .toString(),
                                  onTap: () {}
                              ),
                              TweetIconBtn(
                                  pathName: AssetsConstants.commentIcon,
                                  text: tweet.commentIds.length.toString(),
                                  onTap: () {}
                              ),
                              TweetIconBtn(
                                  pathName: AssetsConstants.retweetIcon,
                                  text: tweet.reSharedCount.toString(),
                                  onTap: () {}
                              ),
                              TweetIconBtn(
                                  pathName: AssetsConstants.likeOutlinedIcon,
                                  text: tweet.likes.length.toString(),
                                  onTap: () {}
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 24,
                                    color: Pallet.greyColor,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 1)
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Pallet.greyColor)
            ],
          );
        },
      error: (error, stackTrace) => ErrorText(error: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
