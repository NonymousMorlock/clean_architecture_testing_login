import 'package:disposable_playground/core/errors/exceptions.dart';
import 'package:disposable_playground/src/features/authentication/data/datasources/auth_remote_data_src.dart';
import 'package:disposable_playground/src/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late AuthRemoteDataSrc remoteDataSrc;

  const tUser = UserModel.empty();

  const tEmail = 'email';
  const tPassword = 'password';

  setUp(() {
    client = MockClient();
    remoteDataSrc = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('login', () {
    test(
      'should return [User] when response code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(fixture('user.json'), 200),
        );

        final result = await remoteDataSrc.login(
          email: tEmail,
          password: tPassword,
        );

        expect(result, tUser);
        verify(
          () => client.get(
            Uri.https(
              'willfind8.com',
              '/Mobileapp/login.php',
              {'email': tEmail, 'password': tPassword},
            ),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ServerException] when response code is not 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response('Error Occurred', 400),
        );
        final call = remoteDataSrc.login;
        expect(
          call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => client.get(
            Uri.https(
              'willfind8.com',
              '/Mobileapp/login.php',
              {'email': tEmail, 'password': tPassword},
            ),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
