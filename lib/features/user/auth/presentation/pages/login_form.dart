import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:servit_project_version_2/core/app/app_dialogs.dart';
import 'package:servit_project_version_2/core/app/app_style.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/cubit/login/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          AppDialogs.showCustomDialog(
            context: context,
            icons: Icons.error,
            title: 'Error',
            content: state.errorMessage ?? 'Authentication Failure',
            onPressed: () => context.pop(),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) => previous.email != current.email,
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      isDense: true,
                      fillColor: pinkColor,
                      filled: true,
                      suffixIcon: const Icon(Icons.email_outlined),
                      errorText: state.email.displayError != null ? 'invalid email' : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: pinkColor2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) => previous.password != current.password,
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      isDense: true,
                      fillColor: pinkColor,
                      filled: true,
                      suffixIcon: const Icon(Icons.password_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: pinkColor2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      errorText: state.password.displayError != null ? 'invalid password' : null,
                    ),
                    // validator: (value) {
                    //   if (value == null || value == '') {
                    //     return 'Can not be empty';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return FilledButton.tonal(
                    onPressed:
                        // if (formKey.currentState!.validate()) {
                        // context.read<AuthBloc>().add(
                        //       OnLoginWithEmail(
                        //         emailController.text,
                        //         passwordController.text,
                        //       ),
                        //     );
                        state.isValid
                            ? () => context.read<LoginCubit>().logInWithCredentials()
                            : null
                    // log('success - login');
                    // }
                    ,
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                      // shape: MaterialStatePropertyAll(
                      //   RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(24),
                      //     ),
                      //   ),
                      // ),
                    ),
                    child: state.status.isInProgress
                        ? const CircularProgressIndicator.adaptive()
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    // child: BlocConsumer<AuthBloc, AuthState>(
                    //   builder: (context, state) {
                    //     if (state is AuthLoading) {
                    //       return CircularProgressIndicator();
                    //     }
                    //     return const Text(
                    //       'Login',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //       ),
                    //     );
                    //   },
                    //   listener: (context, state) {
                    //     if (state is AuthFailure) {
                    //       AppDialogs.showCustomDialog(
                    //         context: context,
                    //         icons: Icons.error,
                    //         title: 'Error',
                    //         content: state.message,
                    //         onPressed: () => context.pop(),
                    //       );
                    //     }
                    //   },
                    // ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
