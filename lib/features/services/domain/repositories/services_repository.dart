import 'package:dartz/dartz.dart';
import 'package:servit_project_version_2/features/services/domain/entities/search_query_entity.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServicesEntity>>> allServices(String? docId);
  Future<Either<Failure, List<ServicesEntity>>> categoryServices(String category);
  Future<Either<Failure, List<ServicesEntity>>> searchServices(
      SearchQueryEntity query, String? docId);
  Future<Either<Failure, List<Map<String, dynamic>>>> categories();
}
