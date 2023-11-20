import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/constants/appwrite_constants.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/core/failure.dart';
import 'package:twitter_clone/app/core/providers.dart';
import 'package:twitter_clone/app/model/notification_model.dart';

final notificationAPIProvider = Provider((ref) {
  return NotificationAPI(
    db: ref.watch(appwriteDatabaseProvider)
  );
});

abstract class INotificationAPI {
  FutureEitherVoid createNotification(Notification notitification);
}

class NotificationAPI implements INotificationAPI {
  final Databases _db;

  NotificationAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid createNotification(Notification notitification) async {
    try {
      await _db.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.notificationsCollectionId,
          documentId: ID.unique(),
          data: notitification.toMap());
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some unexpected error occurred', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
