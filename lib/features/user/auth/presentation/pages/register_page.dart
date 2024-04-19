import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/cubit/register/register_cubit.dart';
import 'package:servit_project_version_2/injection.dart';

import 'register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            30,
            40,
            30,
            30,
          ),
          children: [
            SvgPicture.asset(
              "assets/servit_logo.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              semanticsLabel: 'logo',
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              'Register &\nEverything will be easy',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocProvider(
              create: (context) => locator<RegisterCubit>(),
              child: const RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}
