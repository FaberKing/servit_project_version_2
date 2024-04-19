import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:servit_project_version_2/features/user/auth/domain/entities/email_entity.dart';
import 'package:servit_project_version_2/features/user/auth/domain/entities/password_entity.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/login_with_email_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginWithEmailUseCase) : super(const LoginState());

  final LoginWithEmailUseCase _loginWithEmailUseCase;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _loginWithEmailUseCase(
      state.email.value,
      state.password.value,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: failure.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (data) => emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      ),
    );
  }
}
