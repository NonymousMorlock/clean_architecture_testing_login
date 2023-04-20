import 'package:disposable_playground/src/features/authentication/data/datasources/auth_remote_data_src.dart';
import 'package:disposable_playground/src/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:disposable_playground/src/features/authentication/domain/repos/auth_repo.dart';
import 'package:disposable_playground/src/features/authentication/domain/usecases/login.dart';
import 'package:disposable_playground/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthCubit(login: sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => AuthRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton(http.Client.new);
}
