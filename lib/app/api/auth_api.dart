import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_clone/app/core/core.dart';
import 'package:twitter_clone/app/core/providers.dart';
import 'package:twitter_clone/core/Failure.dart';

final authAPIProvider = Provider((ref) => AuthAPI(account: ref.watch(appwriteAccountProvider)));

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
});
  FutureEither<Account> signIn();

  FutureEither<String> resetPassword({
    required String password
  });
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
  FutureEither<Account> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
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
}