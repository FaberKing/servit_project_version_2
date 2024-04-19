import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/cubit/login/login_cubit.dart';
import 'package:servit_project_version_2/injection.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              'Login &\nEnjoy your needs',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocProvider(
              create: (context) => locator<LoginCubit>(),
              child: const LoginForm(),
            )
          ],
        ),
      ),
    );
  }
}
