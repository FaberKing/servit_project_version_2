import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';

class ServicesModel extends ServicesEntity {
  const ServicesModel({
    required super.id,
    super.serviceName,
    super.storeName,
    super.ownerId,
    super.rate,
    super.rateCount,
    super.location,
    super.description,
    super.cover,
    // super.images,
    super.facilities,
    super.contactNumber,
    // super.isVerify,
    super.category,
  });

  factory ServicesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServicesModel(
      id: data?["id"],
      serviceName: data?['serviceName'],
      storeName: data?['storeName'],
      ownerId: data?['ownerId'],
      rate: double.parse(data?['rate']),
      rateCount: int.parse(data?['rateCount']),
      location: data?['location'],
      description: data?['description'],
      cover: data?['cover'],
      // images: List<String>.from(data?["images"].map((x) => x)),
      facilities: List<Map<String, dynamic>>.from(data?['facilities']),
      contactNumber: data?['contactNumber'],
      // isVerify: data?['isVerify'],
      category: data?['category'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        "id": id,
        if (serviceName != null) "serviceName": serviceName,
        if (storeName != null) "storeName": storeName,
        if (ownerId != null) "ownerId": ownerId,
        if (contactNumber != null) "contactNumber": contactNumber,
        if (rate != null) "rate": rate.toString(),
        if (rateCount != null) "rateCount": rateCount.toString(),
        if (location != null) "location": location,
        if (description != null) "description": description,
        if (cover != null) "cover": cover,
        // if (isVerify != null) "isVerify": isVerify,
        // if (images != null) "images": List<dynamic>.from(images!.map((x) => x)),
        if (facilities != null) "facilities": facilities,
        if (category != null) "category": category,
      };

  ServicesEntity get toEntity => ServicesEntity(
        id: id,
        serviceName: serviceName,
        storeName: storeName,
        ownerId: ownerId,
        rate: rate,
        rateCount: rateCount,
        location: location,
        description: description,
        cover: cover,
        // images: images,
        facilities: facilities,
        contactNumber: contactNumber,
        // isVerify: isVerify,
        category: category,
      );
}
