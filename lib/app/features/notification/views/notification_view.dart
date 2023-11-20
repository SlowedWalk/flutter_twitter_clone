import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/appwrite_constants.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/notification/controller/notification_controller.dart';
import 'package:twitter_clone/app/features/notification/widgets/notification_tile.dart';
import 'package:twitter_clone/app/model/notification_model.dart' as model;

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: currentUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currentUser.uid)).when(
                data: (notifications) {
                  return ref.watch(getLatestNotificationsProvider).when(
                      data: (data) {
                        if (data.events.contains(
                            'databases.*.collections.${AppWriteConstants.notificationsCollectionId}.documents.*.create')) {
                          final latestNotification =
                              model.Notification.fromMap(data.payload);
                          if (latestNotification.uid == currentUser.uid) {
                            notifications.insert(0, latestNotification);
                          }
                        }

                        return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                  notification: notification);
                            });
                      },
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () {
                        return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                  notification: notification);
                            });
                      });
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
    );
  }
}
