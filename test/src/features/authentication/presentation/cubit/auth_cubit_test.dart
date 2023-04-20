import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/data/models/user_model.dart';
import 'package:disposable_playground/src/features/authentication/domain/usecases/login.dart';
import 'package:disposable_playground/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login {}

void main() {
  late MockLogin mockLogin;
  late AuthCubit cubit;

  const tUser = UserModel.empty();

  setUp(() {
    mockLogin = MockLogin();
    cubit = AuthCubit(login: mockLogin);
  });
  group('login', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, LoggedIn] when login is successful',
      build: () {
        when(
          () => mockLogin.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return cubit;
      },
      act: (cubit) => cubit.login(email: '', password: ''),
      expect: () => [
        AuthLoading(),
        const LoggedIn(tUser),
      ],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] when login is unsuccessful',
      build: () {
        when(
          () => mockLogin.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => const Left(
            ServerFailure(
              message: 'message',
              statusCode: 500,
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.login(email: '', password: ''),
      expect: () => [
        AuthLoading(),
        const AuthError('500 Error: message'),
      ],
    );
  });
}
