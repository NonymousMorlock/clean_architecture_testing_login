import 'package:dartz/dartz.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';
import 'package:disposable_playground/src/features/authentication/domain/repos/auth_repo.dart';
import 'package:disposable_playground/src/features/authentication/domain/usecases/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late Login usecase;
  late MockAuthRepo repo;

  setUp(() {
    repo = MockAuthRepo();
    usecase = Login(repo);
  });

  // test to make sure that it returns the correct data type
  // test to make sure that it calls the dependency(REPOSITORY)

  const tEmail = 'test email';
  const tPassword = 'test pass';

  const tUser = User(name: 'Paul', age: 12);

  test('should return a [User] from the [AuthRepo]', () async {
    // arrange
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));
    // act
    final result = await usecase.login(email: tEmail, password: tPassword);
    // assert
    expect(result, equals(const Right<dynamic, User>(tUser)));
    verify(() => repo.login(email: tEmail, password: tPassword));
    verifyNoMoreInteractions(repo);
  });
}
