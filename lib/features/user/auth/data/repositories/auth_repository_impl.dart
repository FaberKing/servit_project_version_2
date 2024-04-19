import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:servit_project_version_2/core/error/exception.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/user/auth/data/datasource/auth_remote_date_source.dart';
import 'package:servit_project_version_2/features/user/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> loginWithEmail(String email, String password) async {
    try {
      final result = await authRemoteDataSource.loginWithEmail(email, password);
      // await authLocalDataSource.setUserData(
      //   await authRemoteDataSource.getCurrentUid(),
      //   // await authRemoteDataSource.getCurrentToken(),
      // );
      return Right(result);
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      debugPrint("Unknown exception : ${e.toString()}");
      return const Left(UnknownFailure('Something went wrong - login'));
    }
  }

  @override
  Future<Either<Failure, void>> registerWithEmail(String email, String password) async {
    try {
      final result = await authRemoteDataSource.registerWithEmail(email, password);

      return Right(result);
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      debugPrint("Unknown exception : ${e.toString()}");
      return const Left(UnknownFailure('Something went wrong - register'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserDataToFirestore(String email, String password) async {
    try {
      final result = await authRemoteDataSource.saveUserDataToFirestore(email, password);

      return Right(result);
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout, No response'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    } catch (e) {
      debugPrint("Unknown exception : ${e.toString()}");
      return const Left(UnknownFailure('Something went wrong - save'));
    }
  }
}
