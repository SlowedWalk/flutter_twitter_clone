import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/api/auth_api.dart';
import 'package:twitter_clone/app/api/user_api.dart';
import 'package:twitter_clone/app/core/utils.dart';
import 'package:twitter_clone/app/features/auth/views/login_view.dart';
import 'package:twitter_clone/app/features/home/views/home_view.dart';
import 'package:twitter_clone/app/model/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider)
  );
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final currentUserDetails = ref.watch(userDetailsProvider(currentUserId));
  return currentUserDetails.value;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
    : _authAPI = authAPI, _userAPI = userAPI, super(false);

  Future<User?> currentUser() => _authAPI.getCurrentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    state = false;
    response.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
          uid: r.$id,
          email: email,
          username: email.split('@')[0],
          followers: const [],
          following: const [],
          profilePic: 'https://picsum.photos/200/300',
          bannerPic: 'https://picsum.photos/200/300',
          bio: '',
          isTwitterBlue: false,
        );
        final res = await _userAPI.saveUserData(userModel);
        res.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, "Account created, please login!");
          Navigator.push(context, LoginView.route());
        });
      }
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.signIn(email: email, password: password);
    state = false;
    response.fold((l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, "Welcome!");
        Navigator.push(context, HomeView.route());
      });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final user = UserModel.fromMap(document.data);
    return user;
  }
}