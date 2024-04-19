import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/user/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmailUseCase {
  final AuthRepository _repository;

  RegisterWithEmailUseCase(this._repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return _repository.registerWithEmail(email, password);
  }
}
