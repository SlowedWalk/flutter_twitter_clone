import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone/app/features/auth/views/login_view.dart';
import 'package:twitter_clone/app/features/home/views/home_view.dart';
import 'package:twitter_clone/app/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Twittify',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
          data: (user) {
            if(user !=null) {
              return const HomeView();
            }
            return const LoginView();
          },
          error: (error, stackTrace) => ErrorPage(
              error: error.toString()
          ),
          loading: () => const LoadingPage()
      ),
    );
  }
}