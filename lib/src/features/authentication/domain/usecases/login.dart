import 'package:dartz/dartz.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';
import 'package:disposable_playground/src/features/authentication/domain/repos/auth_repo.dart';

class Login {
  const Login(this._repo);

  final AuthRepo _repo;

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async =>
      _repo.login(email: email, password: password);
}
