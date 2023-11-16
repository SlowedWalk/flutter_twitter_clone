import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/constants/constants.dart';
import 'package:twitter_clone/app/features/profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/app/features/profile/widgets/user_profile.dart';
import 'package:twitter_clone/app/model/user_model.dart';

class ProfileView extends ConsumerWidget {
  static route(UserModel userModel) => MaterialPageRoute(
      builder: (context) => ProfileView(
        userModel: userModel,
      )
  );
  final UserModel userModel;
  const ProfileView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel userCopy = userModel;

    return Scaffold(
      body: ref.watch(getLatestUserProfileDataProvider).when(
          data: (data) {
            if(data.events.contains(
                'databases.*.collections.${AppWriteConstants.usersCollectionId}.documents.${userCopy.uid}.update'
            )) {
              userCopy = UserModel.fromMap(data.payload);
            }
            return UserProfile(user: userCopy);
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => UserProfile(user: userCopy)
      ),
    );
  }
}