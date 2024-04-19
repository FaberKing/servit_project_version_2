import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/user/auth/data/model/user_model.dart';

import '../auth/domain/repositories/app_repositories.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({required AppRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.getCurrentUser().isNotEmpty
              ? AppState.authenticated(authenticationRepository.getCurrentUser())
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutResquested);
    _userSubscription = _authenticationRepository.user.listen(
      (event) => add(_AppUserChanged(event.id)),
    );
    notifyListeners();
  }

  final AppRepository _authenticationRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated(),
    );
    notifyListeners();
  }

  void _onLogoutResquested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logoutUser());
    notifyListeners();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
