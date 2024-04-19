import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? fName;
  final String? lName;
  final String? email;
  final String? profilePicture;
  final int? phoneNumber;
  final bool? status;
  final FieldValue? createdAt;

  const UserEntity({
    required this.id,
    this.fName,
    this.lName,
    this.email,
    this.profilePicture,
    this.phoneNumber,
    this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      fName,
      lName,
      email,
      profilePicture,
      phoneNumber,
      status,
      createdAt,
    ];
  }
}
