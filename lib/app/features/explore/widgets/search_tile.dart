import 'package:flutter/material.dart';
import 'package:twitter_clone/app/model/user_model.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class SearchTile extends StatelessWidget {
  final UserModel userModel;

  const SearchTile({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userModel.profilePic),
        radius: 30,
      ),
      title: Text(
        userModel.username,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@${userModel.username}',
            style: const TextStyle(
              fontSize: 16,
              color: Pallet.greyColor
            ),
          ),
          Text(
            userModel.bio,
            style: const TextStyle(
              color: Pallet.whiteColor
            ),
          ),
        ],
      ),
    );
  }
}
