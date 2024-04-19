// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ServicesEntity extends Equatable {
  final String id;
  final String? serviceName;
  final String? storeName;
  final String? ownerId;
  final String? contactNumber;
  final double? rate;
  final int? rateCount;
  final String? location;
  final String? description;
  final String? cover;
  final String? category;
  // final bool? isVerify;
  // final List<String>? images;
  final List<Map<String, dynamic>>? facilities;

  const ServicesEntity({
    required this.id,
    this.serviceName,
    this.storeName,
    this.ownerId,
    this.contactNumber,
    this.rate,
    this.rateCount,
    this.location,
    this.description,
    this.cover,
    this.category,
    // this.isVerify,
    // this.images,
    this.facilities,
  });

  @override
  List<Object> get props {
    return [
      id,
      serviceName!,
      storeName!,
      ownerId!,
      contactNumber!,
      rate!,
      rateCount!,
      location!,
      description!,
      cover!,
      category!,
      // isVerify!,
      // images!,
      facilities!,
    ];
  }
}
