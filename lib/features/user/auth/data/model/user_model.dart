import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servit_project_version_2/features/user/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.fName,
    super.lName,
    super.email,
    super.profilePicture,
    super.phoneNumber,
    super.status,
    super.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      fName: data['fName'],
      lName: data['lName'],
      email: data['email'],
      profilePicture: data['profilePhoto'],
      phoneNumber: int.parse(data['phoneNumber']),
      status: data['status'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        "id": id,
        "fName": fName,
        "lName": lName,
        "email": email,
        "profilePicture": profilePicture,
        "phoneNumber": phoneNumber.toString(),
        "status": status,
        "createdAt": createdAt,
      };

  UserEntity get toEntity => UserEntity(
        id: id,
        fName: fName,
        lName: lName,
        email: email,
        profilePicture: profilePicture,
        phoneNumber: phoneNumber,
        status: status,
        createdAt: createdAt,
      );

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object> get props => [];
}
