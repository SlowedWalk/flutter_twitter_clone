import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/core/enums/notification_type_enum.dart';
import 'package:twitter_clone/app/model/notification_model.dart' as model;
import 'package:twitter_clone/app/theme/theme.dart';

class NotificationTile extends StatelessWidget {
  final model.Notification notification;
  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: notification.notificationType == NotificationType.follow
          ? const Icon(Icons.person, color: Pallet.blueColor)
          : notification.notificationType == NotificationType.like
              ? SvgPicture.asset(AssetsConstants.likeFilledIcon,
                  colorFilter:
                      const ColorFilter.mode(Pallet.redColor, BlendMode.srcIn),
                  height: 20)
              : notification.notificationType == NotificationType.retweet
                  ? SvgPicture.asset(AssetsConstants.retweetIcon,
                      colorFilter: const ColorFilter.mode(
                          Pallet.whiteColor, BlendMode.srcIn),
                      height: 20)
                  : null,
      title: Text(notification.text),
    );
  }
}
