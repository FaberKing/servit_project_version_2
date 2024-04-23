import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:servit_project_version_2/core/app/app_style.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/cubit/register/register_cubit.dart';

import '../../../../../core/app/app_dialogs.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pop();
        } else if (state.status.isFailure) {
          AppDialogs.showCustomDialog(
            context: context,
            icons: Icons.error,
            title: 'Error',
            content: state.errorMessage ?? "register error",
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
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.email != current.email,
                builder: (context, state) {
                  return TextFormField(
                    key: const Key('signUpForm_emailInput_textField'),
                    controller: emailController,
                    onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      isDense: true,
                      fillColor: pinkColor,
                      filled: true,
                      suffixIcon: const Icon(Icons.email_outlined),
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
                      errorText: state.email.displayError != null ? 'invalid email' : null,
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
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.password != current.password,
                builder: (context, state) {
                  return TextFormField(
                    key: const Key('signUpForm_passwordInput_textField'),
                    onChanged: (password) =>
                        context.read<RegisterCubit>().passwordChanged(password),
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
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password ||
                    previous.confirmedPassword != current.confirmedPassword,
                builder: (context, state) {
                  return TextFormField(
                    key: const Key('signUpForm_confirmedPasswordInput_textField'),
                    onChanged: (confirmPassword) =>
                        context.read<RegisterCubit>().confirmedPasswordChanged(confirmPassword),
                    obscureText: true,
                    controller: passwordConfirmController,
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
                      errorText: state.confirmedPassword.displayError != null
                          ? 'password do not match'
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return FilledButton.tonal(
                    key: const Key('signUpForm_continue_raisedButton'),
                    onPressed: state.isValid
                        ? () => context.read<RegisterCubit>().registerAndStoreWithCredentials()
                        : null,
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
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    // child: BlocConsumer<AuthBloc, AuthState>(
                    //   builder: (context, state) {
                    //     if (state is AuthLoading) {
                    //       return const CircularProgressIndicator();
                    //     }
                    //     return const Text(`
                    //       'Create Account',
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
                    //     if (state is AuthRegisterSuccess) {
                    //       final data = state.data;
                    //       print(data);
                    //       context.read<AuthBloc>().add(OnSaveUserRegisterData(data));
                    //       // context.read<AuthBloc>().add(OnLogout());
                    //       AppDialogs.showCustomDialog(
                    //         context: context,
                    //         icons: Icons.check,
                    //         title: 'Success',
                    //         content:
                    //             "${state.data.user!.email.toString()} account have been created",
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
