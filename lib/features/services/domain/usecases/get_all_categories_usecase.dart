import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';

class GetAllCategoriesUseCase {
  final ServicesRepository _repository;

  GetAllCategoriesUseCase(this._repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> call() {
    return _repository.categories();
  }
}
