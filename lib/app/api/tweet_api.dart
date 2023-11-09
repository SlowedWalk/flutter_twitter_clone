import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/app/constants/appwrite_constants.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/core/failure.dart';
import 'package:twitter_clone/app/core/providers.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';


final tweetAPIProvider = Provider((ref) {
  return TweetAPI(
      db: ref.watch(appwriteDatabaseProvider)
  );
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweets();
}

class TweetAPI implements ITweetAPI {
  final Databases _db;
  TweetAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollectionId,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'An unexpected error occurred', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getTweets() async {
      final documents = await _db.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollectionId
    );
      return documents.documents;
  }
}
