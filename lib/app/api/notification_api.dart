import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/constants/appwrite_constants.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/core/failure.dart';
import 'package:twitter_clone/app/core/providers.dart';
import 'package:twitter_clone/app/model/notification_model.dart';

final notificationAPIProvider = Provider((ref) {
  return NotificationAPI(
      db: ref.watch(appwriteDatabaseProvider),
      realtime: ref.watch(appwriteRealtimeProvider));
});

abstract class INotificationAPI {
  FutureEitherVoid createNotification(Notification notitification);
  Future<List<Document>> getNotifications(String uid);
  Stream<RealtimeMessage> getLatestNotifications();
}

class NotificationAPI implements INotificationAPI {
  final Databases _db;
  final Realtime _realtime;

  NotificationAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;

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

  @override
  Future<List<Document>> getNotifications(String uid) async {
    final documents = await _db.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.notificationsCollectionId,
      queries: [Query.equal('uid', uid)],
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestNotifications() {
    return _realtime.subscribe([
      'databases.${AppWriteConstants.databaseId}.collections.${AppWriteConstants.notificationsCollectionId}.documents'
    ]).stream;
  }
}
