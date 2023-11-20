import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/loading_page.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/app/features/profile/views/profile_view.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    if (currentUser == null) return const Loader();

    return SafeArea(
      child: Drawer(
        backgroundColor: Pallet.backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              horizontalTitleGap: 50,
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(context, ProfileView.route(currentUser));
              },
            ),
            ListTile(
              horizontalTitleGap: 50,
              leading: const Icon(
                Icons.payment,
                size: 30,
              ),
              title: const Text(
                'Twitter Blue',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                ref
                  .read(userProfileControllerProvider.notifier)
                  .updateUserProfile(
                    userModel: currentUser.copyWith(isTwitterBlue: true),
                    context: context,
                    bannerFile: null,
                    profileImageFile: null
                );
              },
            ),
            ListTile(
              horizontalTitleGap: 50,
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
