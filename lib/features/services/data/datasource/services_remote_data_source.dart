import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servit_project_version_2/features/services/data/model/search_query_model.dart';
import 'package:servit_project_version_2/features/services/data/model/services_model.dart';

import '../../../../core/error/exception.dart';

abstract class ServicesRemoteDataSource {
  Future<List<ServicesModel>> allServices(String? startDocId);
  Future<List<ServicesModel>> categoryServices(String category);
  Future<List<ServicesModel>> searchServices(SearchQueryModel query, String? startDocId);
  Future<List<Map<String, dynamic>>> categories();
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ServicesRemoteDataSourceImpl(
    this.firebaseFirestore,
  );

  @override
  Future<List<ServicesModel>> allServices(String? docId) async {
    try {
      // final result = await FirebaseFirestore.instance.collection('Store').limit(10).get();
      // return result.docs.map((e) => ServicesModel.fromFirestore(e.data())).toList();
      if (docId == null || docId.isEmpty) {
        final result = await FirebaseFirestore.instance
            .collection('services')
            .withConverter(
              fromFirestore: ServicesModel.fromFirestore,
              toFirestore: (ServicesModel servicesModel, options) => servicesModel.toFirestore(),
            )
            // .orderBy('id', descending: true)
            .limit(10)
            .get();
        return result.docs.map((e) => e.data()).toList();
      }

      final startAfterDoc =
          await FirebaseFirestore.instance.collection('services').doc(docId).get();

      final result = await FirebaseFirestore.instance
          .collection('services')
          .withConverter(
            fromFirestore: ServicesModel.fromFirestore,
            toFirestore: (ServicesModel servicesModel, options) => servicesModel.toFirestore(),
          )
          // .orderBy('id', descending: true)
          .startAfterDocument(startAfterDoc)
          .limit(10)
          .get();
      return result.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<List<ServicesModel>> categoryServices(String category) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('services')
          .withConverter(
            fromFirestore: ServicesModel.fromFirestore,
            toFirestore: (ServicesModel servicesModel, options) => servicesModel.toFirestore(),
          )
          .where("category", isEqualTo: category)
          .get();
      if (result.docs.isEmpty) {
        throw NotFoundException();
      } else {
        // return result.docs.map((e) => ServicesModel.fromFirestore(e.data())).toList();
        return result.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<List<ServicesModel>> searchServices(SearchQueryModel query, String? startDocId) async {
    try {
      if (startDocId == null || startDocId.isEmpty) {
        final result = await FirebaseFirestore.instance
            .collection('services')
            .withConverter(
              fromFirestore: ServicesModel.fromFirestore,
              toFirestore: (ServicesModel servicesModel, options) => servicesModel.toFirestore(),
            )
            .where(
              Filter.and(
                Filter("serviceName", isGreaterThanOrEqualTo: '${query.querySearch}'),
                Filter("serviceName", isLessThanOrEqualTo: '${query.querySearch}\uf8ff'),
              ),
            )
            .where(
              Filter.and(
                Filter("category", isGreaterThanOrEqualTo: '${query.queryCategory}'),
                Filter("category", isLessThanOrEqualTo: '${query.queryCategory}\uf8ff'),
              ),
            )
            // .orderBy('id', descending: true)
            .limit(10)
            .get();
        return result.docs.map((e) => e.data()).toList();
      }

      final startAfterDoc =
          await FirebaseFirestore.instance.collection('services').doc(startDocId).get();

      final result = await FirebaseFirestore.instance
          .collection('services')
          .withConverter(
            fromFirestore: ServicesModel.fromFirestore,
            toFirestore: (ServicesModel servicesModel, options) => servicesModel.toFirestore(),
          )
          .where(
            Filter.or(
              Filter("serviceName", isEqualTo: query),
              Filter("facilities", arrayContains: query),
            ),
          )
          .startAfterDocument(startAfterDoc)
          .limit(10)
          .get();

      if (result.docs.isEmpty) {
        throw NotFoundException();
      } else {
        // return result.docs.map((e) => ServicesModel.fromFirestore(e.data())).toList();
        return result.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> categories() async {
    try {
      final result = await FirebaseFirestore.instance.collection('categories').get();
      return result.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }
}
