import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servit_project_version_2/core/error/exception.dart';
import 'package:servit_project_version_2/core/error/failure.dart';
import 'package:servit_project_version_2/features/user/auth/data/model/user_model.dart';

abstract class AppRemoteDataSource {
  Future<String> getCurrentUid();
  Future<void> logoutUser();
  Stream<UserModel> get user;
}

class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AppRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );

  @override
  Stream<UserModel> get user {
    return firebaseAuth.authStateChanges().map((event) {
      final user = event == null
          ? UserModel.empty
          : UserModel(
              id: event.uid,
              email: event.email,
            );
      return user;
    });
  }

  @override
  Future<String> getCurrentUid() async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
      ]);
    } catch (e) {
      throw LogOutFailure(e.toString());
    }
  }
}
