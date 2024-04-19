import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/core/app/app.dart';
import 'package:servit_project_version_2/core/app/bloc/app_bloc.dart';
import 'package:servit_project_version_2/core/app/bloc_observer.dart';
import 'package:servit_project_version_2/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await initLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(BlocProvider(
    create: (context) => locator<AppBloc>(),
    child: const MainApp(),
  ));
}
