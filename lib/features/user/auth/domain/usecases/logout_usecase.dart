import '../../../../../core/app/auth/domain/repositories/app_repositories.dart';

class LogoutUseCase {
  final AppRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() {
    return _repository.logoutUser();
  }
}
