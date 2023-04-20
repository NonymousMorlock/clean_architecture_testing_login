import 'package:dartz/dartz.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
