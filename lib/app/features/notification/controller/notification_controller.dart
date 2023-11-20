import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/api/notification_api.dart';
import 'package:twitter_clone/app/core/enums/notification_type_enum.dart';
import 'package:twitter_clone/app/core/utils.dart';
import 'package:twitter_clone/app/model/notification_model.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  return NotificationController(
    notificationAPI: ref.watch(notificationAPIProvider)
  );
});

class NotificationController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;

  NotificationController({
    required NotificationAPI notificationAPI,
  }) : _notificationAPI = notificationAPI,
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
        id: ''
      );

      final res = await _notificationAPI.createNotification(notification);

      return res.fold(
        (l) => log(l.message),
        (r) => null
      );
    }
}