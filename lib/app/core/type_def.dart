import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/app/core/Failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
