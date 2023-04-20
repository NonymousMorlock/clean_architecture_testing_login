import 'package:bloc/bloc.dart';
import 'package:disposable_playground/core/errors/failures.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';
import 'package:disposable_playground/src/features/authentication/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required Login login})
      : _login = login,
        super(AuthInitial());

  final Login _login;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _login.login(email: email, password: password);
    result.fold(
      (failure) => emit(
        AuthError('${failure is ServerFailure ? failure.statusCode : 'Unknown'}'
            ' Error: ${failure.message}'),
      ),
      (user) => emit(LoggedIn(user)),
    );
  }
}
