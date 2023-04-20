import 'package:dartz/dartz.dart';
import 'package:disposable_playground/core/errors/exceptions.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/data/datasources/auth_remote_data_src.dart';
import 'package:disposable_playground/src/features/authentication/data/models/user_model.dart';
import 'package:disposable_playground/src/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSrc {}

void main() {
  late MockAuthRemoteDataSrc remoteDataSrc;
  late AuthRepoImpl repoImpl;

  const tUser = UserModel.empty();

  const tEmail = 'email';
  const tPassword = 'password';

  setUp(() {
    remoteDataSrc = MockAuthRemoteDataSrc();
    repoImpl = AuthRepoImpl(remoteDataSrc);
  });

  group('login', () {
    test(
      'should return a [User] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSrc.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);

        final result = await repoImpl.login(email: tEmail, password: tPassword);

        expect(result, equals(const Right<dynamic, UserModel>(tUser)));
        verify(
          () => remoteDataSrc.login(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source '
      'is unsuccessful',
      () async {
        when(
          () => remoteDataSrc.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const ServerException(message: 'Error', statusCode: 500));

        final result = await repoImpl.login(email: tEmail, password: tPassword);

        expect(
          result,
          equals(
            const Left<ServerFailure, dynamic>(
              ServerFailure(message: 'Error', statusCode: 500),
            ),
          ),
        );

        verify(() => remoteDataSrc.login(email: tEmail, password: tPassword))
            .called(1);

        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
