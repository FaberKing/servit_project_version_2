import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';

class GetServicesByCategoryUseCase {
  final ServicesRepository _repository;

  GetServicesByCategoryUseCase(this._repository);

  Future<Either<Failure, List<ServicesEntity>>> call({required String category}) {
    return _repository.categoryServices(category);
  }
}
