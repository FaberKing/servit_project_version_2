// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';

// import 'package:servit_project_version_2/core/common/platform/network_info.dart';
import 'package:servit_project_version_2/core/error/exception.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/services/data/datasource/services_remote_data_source.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/repositories/services_repository.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  // final NetworkInfo networkInfo;
  final ServicesRemoteDataSource servicesRemoteDataSource;

  ServicesRepositoryImpl({
    // required this.networkInfo,
    required this.servicesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<ServicesEntity>>> allServices(String? docId) async {
    try {
      final result = await servicesRemoteDataSource.allServices(docId);
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      return Left(UnknownFailure('Something went wrong - allServices ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ServicesEntity>>> categoryServices(String category) async {
    try {
      final result = await servicesRemoteDataSource.categoryServices(category);
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on NotFoundException {
      return const Left(NotFoundFailure('Item is not found'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      return const Left(UnknownFailure('Something went wrong - categoryServices'));
    }
  }

  @override
  Future<Either<Failure, List<ServicesEntity>>> searchServices(
    String query,
    String? startDocId,
  ) async {
    try {
      final result = await servicesRemoteDataSource.searchServices(query, startDocId);
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on NotFoundException {
      return const Left(NotFoundFailure('Item is not found'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      return const Left(UnknownFailure('Something went wrong - searchServices'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> categories() async {
    try {
      final result = await servicesRemoteDataSource.categories();
      return Right(result);
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      return const Left(UnknownFailure('Something went wrong - categories'));
    }
  }
}
