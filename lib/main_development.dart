import 'package:disposable_playground/app/app.dart';
import 'package:disposable_playground/bootstrap.dart';
import 'package:disposable_playground/core/services/injection_container.dart';
import 'package:disposable_playground/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await bootstrap(
    () => BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: const App(),
    ),
  );
}
