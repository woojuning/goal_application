import 'package:fpdart/fpdart.dart';
import 'package:my_goal_app/core/common/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEithervoid = Future<Either<Failure, void>>;
