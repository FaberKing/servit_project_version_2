import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:servit_project_version_2/core/app/app_style.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/widgets/basic_shadow.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: background(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 0.5,
              width: double.infinity,
              child: const BasicShadow(
                topDown: false,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            child: const BasicShadow(
              topDown: true,
            ),
          ),
          buildContent(context),
        ],
      ),
    );
  }

  SafeArea buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/servit_logo.svg",
              colorFilter: ColorFilter.mode(
                pinkColor1,
                BlendMode.srcIn,
              ),
              semanticsLabel: 'eee',
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              'Get Started',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 300,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: FilledButton.tonal(
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size.fromHeight(50),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Facebook',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: FilledButton.tonal(
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size.fromHeight(50),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Gmail',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () {
                context.go('/login');
              },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(
                  Size(double.infinity, 50),
                ),
              ),
              child: const Text(
                'Login With Email',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 35),
            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: Text(
                'Register With Email',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget background() {
    return Image.asset(
      "assets/start_background.jpg",
      fit: BoxFit.cover,
    );
  }
}
