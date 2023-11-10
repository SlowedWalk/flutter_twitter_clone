import 'package:flutter/foundation.dart';
import 'package:twitter_clone/app/core/enums/tweet_type_enum.dart';

@immutable
class Tweet {
  final String uid;
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reSharedCount;
  final String reTweetedBy;

//<editor-fold desc="Data Methods">
  const Tweet({
    required this.uid,
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reSharedCount,
    required this.reTweetedBy,
  });

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      (other is Tweet &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          text == other.text &&
          listEquals(other.hashtags, hashtags) &&
          link == other.link &&
          listEquals(other.imageLinks, imageLinks) &&
          tweetType == other.tweetType &&
          tweetedAt == other.tweetedAt &&
          listEquals(other.likes, likes) &&
          listEquals(other.commentIds, commentIds) &&
          id == other.id &&
          reSharedCount == other.reSharedCount &&
          reTweetedBy == other.reTweetedBy);

  @override
  int get hashCode =>
      uid.hashCode ^
      text.hashCode ^
      hashtags.hashCode ^
      link.hashCode ^
      imageLinks.hashCode ^
      tweetType.hashCode ^
      tweetedAt.hashCode ^
      likes.hashCode ^
      commentIds.hashCode ^
      id.hashCode ^
      reSharedCount.hashCode ^
      reTweetedBy.hashCode;

  @override
  String toString() {
    return 'Tweet{ uid: $uid, text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reSharedCount: $reSharedCount, reTweetedBy: $reTweetedBy}';
  }

  Tweet copyWith({
    String? uid,
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reSharedCount,
    String? reTweetedBy,
  }) {
    return Tweet(
      uid: uid ?? this.uid,
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reSharedCount: reSharedCount ?? this.reSharedCount,
      reTweetedBy: reTweetedBy ?? this.reTweetedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'text': text,
      'hashtags': hashtags,
      'link': link,
      'imageLinks': imageLinks,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reSharedCount': reSharedCount,
      'reTweetedBy': reTweetedBy,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      uid: map['uid'] ?? '',
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      reSharedCount: map['reSharedCount']?.toInt() ?? 0,
      reTweetedBy: map['reTweetedBy'] ?? '',
    );
  }

//</editor-fold>
}