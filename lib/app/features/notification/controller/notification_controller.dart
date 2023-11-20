import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/api/notification_api.dart';
import 'package:twitter_clone/app/core/enums/notification_type_enum.dart';
import 'package:twitter_clone/app/core/utils.dart';
import 'package:twitter_clone/app/model/notification_model.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  return NotificationController(
      notificationAPI: ref.watch(notificationAPIProvider));
});

final getLatestNotificationsProvider = StreamProvider((ref) {
  final notificationAPI = ref.watch(notificationAPIProvider);
  return notificationAPI.getLatestNotifications();
});

final getNotificationsProvider = FutureProvider.family((ref, String uid) async {
  final notificationController =
      ref.watch(notificationControllerProvider.notifier);
  return notificationController.getNotifications(uid);
});

class NotificationController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;

  NotificationController({
    required NotificationAPI notificationAPI,
  })  : _notificationAPI = notificationAPI,
        super(false);

  void createNotification({
    required String text,
    required String tweetId,
    required NotificationType notificationType,
    required String uid,
  }) async {
    final notification = Notification(
        text: text,
        tweetId: tweetId,
        notificationType: notificationType,
        uid: uid,
        id: '');

    final res = await _notificationAPI.createNotification(notification);

    return res.fold((l) => null, (r) => null);
  }

  Future<List<Notification>> getNotifications(String uid) async {
    final notifications = await _notificationAPI.getNotifications(uid);
    return notifications.map((e) => Notification.fromMap(e.data)).toList();
  }
}
