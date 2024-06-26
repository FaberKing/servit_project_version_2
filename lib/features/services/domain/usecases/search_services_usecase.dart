import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/services/domain/entities/search_query_entity.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';

class SearchServicesUseCase {
  final ServicesRepository _repository;

  SearchServicesUseCase(this._repository);

  Future<Either<Failure, List<ServicesEntity>>> call(
      {required SearchQueryEntity query, String? docId}) {
    return _repository.searchServices(query, docId);
  }
}
