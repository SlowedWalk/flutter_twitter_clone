import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/app/theme/pallet.dart';


class EditProfileView extends ConsumerStatefulWidget {
static route() => MaterialPageRoute(
    builder: (context) => const EditProfileView()
);

  const EditProfileView({super.key});

  @override
  ConsumerState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  File? bannerFile;
  File? profileImageFile;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: ref.read(currentUserDetailsProvider).value?.username ?? ''
    );

    bioController = TextEditingController(
        text: ref.read(currentUserDetailsProvider).value?.bio ?? ''
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  void selectBannerImage() async {
    final banner = await pickImage();
    if (banner != null) {
      setState(() {
        bannerFile = banner;
      });
    }
  }

  void selectProfileImage() async {
    final profileImage = await pickImage();
    if (profileImage != null) {
      setState(() {
        profileImageFile = profileImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(userProfileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {
                ref.read(userProfileControllerProvider.notifier)
                    .updateUserProfile(
                    userModel: currentUser!.copyWith(
                      bio: bioController.text,
                      username: nameController.text
                    ),
                    context: context,
                    bannerFile: bannerFile,
                    profileImageFile: profileImageFile
                );
              },
              child: const Text("Save")
          )
        ],
      ),
      body: isLoading || currentUser == null
          ? const Loader()
          : Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(children: [
                  GestureDetector(
                    onTap: selectBannerImage,
                    child: Container(
                      width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: bannerFile != null
                            ? Image.file(bannerFile!, fit: BoxFit.fitHeight)
                            : currentUser.bannerPic.isEmpty
                              ? Container(color: Pallet.blueColor)
                              : Image.network(currentUser.bannerPic, fit: BoxFit.fitHeight)
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    child: GestureDetector(
                      onTap: selectProfileImage,
                      child: profileImageFile != null
                          ?  CircleAvatar(
                               backgroundImage: FileImage(profileImageFile!),
                               radius: 35
                             )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(currentUser.profilePic),
                              radius: 35,
                          ),
                    ),
                  ),
                ]),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  contentPadding: EdgeInsets.all(18)
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  hintText: "Bio",
                  contentPadding: EdgeInsets.all(18)
                ),
                maxLength: 4,
              ),
            ],
          ),
    );
  }
}
