import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> registerWithEmail(String email, String password);
  Future<Either<Failure, void>> loginWithEmail(String email, String password);
  Future<Either<Failure, void>> saveUserDataToFirestore(String email, String password);
}
