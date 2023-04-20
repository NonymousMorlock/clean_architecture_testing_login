import 'package:disposable_playground/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:disposable_playground/src/features/authentication/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size size;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void signIn() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<AuthCubit>().login(
            email: emailController.text,
            password: passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthError) {
            if (loading) {
              Navigator.of(context).pop();
              loading = false;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is AuthLoading) {
            loading = true;
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is LoggedIn) {
            if (loading) {
              Navigator.of(context).pop();
              loading = false;
            }
            // TODO(POST-LOGIN): Navigate to Home Page
          }
        },
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    height: 1.5,
                  ),
                ),
                Text(
                  'Enter your credentials to sign in',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 50),
                AuthField(
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onSubmit: (_) => signIn(),
                ),
                const SizedBox(height: 20),
                AuthField(
                  labelText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  onSubmit: (_) => signIn(),
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                    ),
                    onPressed: signIn,
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
