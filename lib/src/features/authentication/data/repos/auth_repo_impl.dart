import 'package:dartz/dartz.dart';
import 'package:disposable_playground/core/errors/exceptions.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/data/datasources/auth_remote_data_src.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';
import 'package:disposable_playground/src/features/authentication/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl(this._remoteDataSrc);

  final AuthRemoteDataSrc _remoteDataSrc;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSrc.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
