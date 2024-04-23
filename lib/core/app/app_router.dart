import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servit_project_version_2/core/app/bloc/app_bloc.dart';
import 'package:servit_project_version_2/core/common/widgets/scaffold_navigation.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_category/all_category_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_services/all_services_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/search_services/search_services_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/services_by_category/services_by_category_bloc.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/pages/login_page.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/pages/register_page.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/pages/start_page.dart';
import 'package:servit_project_version_2/injection.dart';

import '../../features/services/presentation/pages/search_page.dart';
import '../../features/services/presentation/pages/home_page.dart';

abstract class AppRouter {
  static GoRouter router(
    ValueKey<String> scaffoldKey,
    BuildContext context,
  ) =>
      GoRouter(
        initialLocation: '/',
        debugLogDiagnostics: true,
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => const StartPage(),
            routes: <RouteBase>[
              GoRoute(
                path: 'login',
                builder: (context, state) => const LoginPage(),
              ),
              GoRoute(
                path: 'register',
                builder: (context, state) => const RegisterPage(),
              ),
            ],
          ),
          GoRoute(
              path: '/home',
              pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
                    key: scaffoldKey,
                    child: NavigationScaffold(
                      selectedTab: ScaffoldTab.home,
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => locator<AllCategoryBloc>(),
                          ),
                          BlocProvider(
                            create: (context) => locator<AllServicesBloc>(),
                          ),
                        ],
                        child: const HomePage(
                          ee: 'ssa',
                        ),
                      ),
                    ),
                  ),
              routes: [
                GoRoute(
                  path: 'list_search/search',
                  name: 'list_search',
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      child: MultiBlocProvider(providers: [
                        BlocProvider(
                          create: (context) => locator<SearchServicesBloc>(),
                        ),
                        BlocProvider(
                          create: (context) => locator<ServicesByCategoryBloc>(),
                        ),
                      ], child: const SearchPage()),
                    );
                  },
                )
              ]),
          GoRoute(
            path: '/favorite',
            pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
              key: scaffoldKey,
              child: const NavigationScaffold(
                selectedTab: ScaffoldTab.favorite,
                child: HomePage(ee: 'favor'),
              ),
            ),
          ),
          GoRoute(
            path: '/notifikasi',
            pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
              key: scaffoldKey,
              child: const NavigationScaffold(
                selectedTab: ScaffoldTab.notifikasi,
                child: HomePage(ee: 'notif'),
              ),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
              key: scaffoldKey,
              child: const NavigationScaffold(
                selectedTab: ScaffoldTab.profile,
                child: HomePage(ee: 'pro'),
              ),
            ),
          ),
        ],
        redirect: (context, state) {
          //   // final stateBloc = context.read<AuthBloc>().state;
          final authState = context.read<AppBloc>().state;

          // final isLoggedin = stateBloc is AuthSuccess;
          //   // log(authState.status.toString());
          final isLoggedin2 = authState.status == AppStatus.authenticated;
          final isLoggedin3 = authState.status == AppStatus.unauthenticated;

          //   // final userId = await locator<GetCurrentUserIdUseCase>().call();

          //   // log("$userId from Router");

          if (isLoggedin2) {
            if (state.matchedLocation == '/' ||
                state.matchedLocation == '/login' ||
                state.matchedLocation == '/register') {
              return '/home';
            }
          }

          if (isLoggedin3) {
            if (!(state.matchedLocation == '/' ||
                state.matchedLocation == '/login' ||
                state.matchedLocation == '/register')) {
              return '/';
            }
          }

          return null;
        },
        refreshListenable: context.watch<AppBloc>(),
      );
}
