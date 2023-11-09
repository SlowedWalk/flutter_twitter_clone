import 'package:flutter/material.dart';
import 'package:twitter_clone/app/core/enums/tweet_type_enum.dart';

@immutable
class Tweet {
  final String uid;
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imagesLinks;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reSharedCount;

//<editor-fold desc="Data Methods">
  const Tweet({
    required this.uid,
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imagesLinks,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reSharedCount,
  });

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      (other is Tweet &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          text == other.text &&
          hashtags == other.hashtags &&
          link == other.link &&
          imagesLinks == other.imagesLinks &&
          tweetType == other.tweetType &&
          tweetedAt == other.tweetedAt &&
          likes == other.likes &&
          commentIds == other.commentIds &&
          id == other.id &&
          reSharedCount == other.reSharedCount);

  @override
  int get hashCode =>
      uid.hashCode ^
      text.hashCode ^
      hashtags.hashCode ^
      link.hashCode ^
      imagesLinks.hashCode ^
      tweetType.hashCode ^
      tweetedAt.hashCode ^
      likes.hashCode ^
      commentIds.hashCode ^
      id.hashCode ^
      reSharedCount.hashCode;

  @override
  String toString() {
    return 'Tweet{ uid: $uid, text: $text, hashtags: $hashtags, link: $link, imagesLinks: $imagesLinks, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reSharedCount: $reSharedCount,}';
  }

  Tweet copyWith({
    String? uid,
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imagesLinks,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reSharedCount,
  }) {
    return Tweet(
      uid: uid ?? this.uid,
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imagesLinks: imagesLinks ?? this.imagesLinks,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reSharedCount: reSharedCount ?? this.reSharedCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'text': text,
      'hashtags': hashtags,
      'link': link,
      'imagesLinks': imagesLinks,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reSharedCount': reSharedCount,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      uid: map['uid'] ?? '',
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imagesLinks: List<String>.from(map['imagesLinks']),
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      reSharedCount: map['reSharedCount']?.toInt() ?? 0,
    );
  }

//</editor-fold>
}