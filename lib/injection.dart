import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:servit_project_version_2/core/app/auth/data/datasource/app_local_data_source.dart';
import 'package:servit_project_version_2/core/app/auth/data/datasource/app_remote_data_source.dart';
import 'package:servit_project_version_2/core/app/auth/data/repositories/app_repository_impl.dart';
import 'package:servit_project_version_2/core/app/auth/domain/repositories/app_repositories.dart';
import 'package:servit_project_version_2/core/app/bloc/app_bloc.dart';
import 'package:servit_project_version_2/features/services/data/datasource/services_remote_data_source.dart';
import 'package:servit_project_version_2/features/services/data/repositories/services_repository_impl.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_all_categories_usecase.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_all_services_usecase.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_services_by_category_usecase.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/search_services_usecase.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_category/all_category_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_services/all_services_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/search_services/search_services_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/services_by_category/services_by_category_bloc.dart';
import 'package:servit_project_version_2/features/user/auth/data/datasource/auth_remote_date_source.dart';
import 'package:servit_project_version_2/features/user/auth/data/repositories/auth_repository_impl.dart';
import 'package:servit_project_version_2/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/logout_usecase.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/save_user_register_data_usecase.dart';
import 'package:servit_project_version_2/features/user/auth/presentation/cubit/login/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => AppBloc(authenticationRepository: locator()));

  //cubit
  locator.registerFactory(() => LoginCubit(locator()));

  locator.registerFactory(() => AllCategoryBloc(locator()));
  locator.registerFactory(() => AllServicesBloc(locator()));
  locator.registerFactory(() => SearchServicesBloc(locator()));
  locator.registerFactory(() => ServicesByCategoryBloc(locator()));

  // usecase
  // - auth
  locator.registerLazySingleton(
    () => LoginWithEmailUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => LogoutUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => RegisterWithEmailUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => SaveUserRegisterDataUseCase(locator()),
  );

  // - services
  locator.registerLazySingleton(
    () => GetAllCategoriesUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => GetAllServicesUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => GetServicesByCategoryUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => SearchServicesUseCase(locator()),
  );

  // repository
  // - auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: locator()),
  );

  // - app
  locator.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(authRemoteDataSource: locator(), authLocalDataSource: locator()),
  );

  // - services
  locator.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(servicesRemoteDataSource: locator()),
  );

  // datasource
  // - auth

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator(), locator()),
  );

  // - app
  locator.registerLazySingleton<AppRemoteDataSource>(
    () => AppRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImpl(locator()),
  );

  // - services
  locator.registerLazySingleton<ServicesRemoteDataSource>(
    () => ServicesRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton(() => AuthRepositoryImpl(authRemoteDataSource: locator()));

  locator.registerLazySingleton(
      () => AppRepositoryImpl(authRemoteDataSource: locator(), authLocalDataSource: locator()));
  // external
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);

  // internal
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
}
