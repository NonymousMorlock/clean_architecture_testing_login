import 'package:disposable_playground/core/errors/exceptions.dart';
import 'package:disposable_playground/src/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.get(
        Uri.https(
          'willfind8.com',
          '/Mobileapp/login.php',
          {'email': email, 'password': password},
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromJson(response.body);
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
