import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servit_project_version_2/core/error/exception.dart';
import 'package:servit_project_version_2/features/user/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> registerWithEmail(String email, String password);
  Future<void> loginWithEmail(String email, String password);
  Future<void> saveUserDataToFirestore(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );

  @override
  Future<void> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // return credential;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<void> saveUserDataToFirestore(String email, String password) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      // final regisData = credential.user!;

      final user = UserModel(
        id: uid,
        fName: "",
        lName: "",
        email: email,
        profilePicture: "",
        phoneNumber: 0,
        status: false,
        createdAt: FieldValue.serverTimestamp(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(user.toFirestore(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
