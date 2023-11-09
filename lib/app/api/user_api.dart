import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/core/failure.dart';
import 'package:twitter_clone/app/core/providers.dart';
import 'package:twitter_clone/app/model/user_model.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider)
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollectionId,
        documentId: userModel.uid,
        data: userModel.toMap());
        return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? 'Some unexpected error occurred', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<Document> getUserData(String uid) async {
   return _db.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollectionId,
      documentId: uid,
    );
  }
}