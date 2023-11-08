import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import '../core/core.dart';
import '../core/providers.dart';
import '../core/Failure.dart';

final authAPIProvider = Provider((ref) => AuthAPI(account: ref.watch(appwriteAccountProvider)));

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
});
  FutureEither<Session> signIn({
    required String email,
    required String password,
  });

  FutureEither<String> resetPassword({
    required String password
  });

  Future<User?> getCurrentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}): _account = account;

  @override
  FutureEither<String> resetPassword({ required String password }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  FutureEither<Session> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch(e, stackTrace) {
      return left(Failure(e.message ?? 'An Unexpected error occurred!', stackTrace));
    } catch(e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<User> signUp({ required String email, required String password }) async {
    try {
      final account = await _account.create(userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch(e, stackTrace) {
      return left(Failure(e.message ?? 'An Unexpected error occurred!', stackTrace));
    } catch(e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<User?> getCurrentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch(e) {
      return null;
    }
  }
}