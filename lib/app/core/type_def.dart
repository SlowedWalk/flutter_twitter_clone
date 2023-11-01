import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/Failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
