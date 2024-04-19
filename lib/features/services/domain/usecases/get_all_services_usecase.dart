import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';

class GetAllServicesUseCase {
  final ServicesRepository _repository;

  GetAllServicesUseCase(this._repository);

  Future<Either<Failure, List<ServicesEntity>>> call({String? docId}) {
    return _repository.allServices(docId);
  }
}
