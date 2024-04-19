// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart' as form_other;
import 'package:formz/formz.dart';

import 'package:servit_project_version_2/features/user/auth/domain/entities/email_entity.dart';
import 'package:servit_project_version_2/features/user/auth/domain/entities/password_entity.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:servit_project_version_2/features/user/auth/domain/usecases/save_user_register_data_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._registerWithEmailUseCase,
    this._saveUserRegisterDataUseCase,
  ) : super(const RegisterState());

  final RegisterWithEmailUseCase _registerWithEmailUseCase;
  final SaveUserRegisterDataUseCase _saveUserRegisterDataUseCase;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = form_other.ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = form_other.ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> registerWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _registerWithEmailUseCase(
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

  Future<void> storeCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _saveUserRegisterDataUseCase(
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

  Future<void> registerAndStoreWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final registerResult = await _registerWithEmailUseCase(
      state.email.value,
      state.password.value,
    );

    final storeResult = await _saveUserRegisterDataUseCase(
      state.email.value,
      state.password.value,
    );

    final combinedResult = [registerResult, storeResult];

    for (var result in combinedResult) {
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
}
