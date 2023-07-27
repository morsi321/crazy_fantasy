import 'package:crazy_fantasy/feauters/add%20organizer/Data/models/orgnizer_model.dart';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'addOrganizerRepo.dart';

class AddOrganizerRepoImpl implements AddOrganizerRepo {
  @override
  Future<Either<String, String>> addOrganizer(
      {required Organizer organizerModel}) async {
    try {
      CollectionReference organizers =
          FirebaseFirestore.instance.collection('organizers');
      await organizers
          .doc()
          .set(organizerModel.toJson(), SetOptions(merge: true));
      return const Right('تم اضافه المنظم بنجاح');
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
    // TODO: implement addOrganizer
  }

  @override
  Future<Either<String, String>> deleteOrganizer({required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection('organizers')
          .doc(id)
          .delete();
      return const Right('تم حذف المنظم بنجاح');
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, String>> updateOrganizer(
      {required String id, required Organizer organizerModel}) async {
    // TODO: implement updateOrganizer
    try {
      await FirebaseFirestore.instance
          .collection('organizers')
          .doc(id)
          .update(organizerModel.toJson());
      return const Right('تم تعديل المنظم بنجاح');
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, List<Organizer>>> getOrganizer() async {
    try {
      List<Organizer> listOrganizer = [];
      QuerySnapshot organizers =await
          FirebaseFirestore.instance.collection('organizers').get();
            for (var org in organizers.docs) {
              String id = org.reference.id;
          listOrganizer.add(Organizer.fromJson( org.data() as Map<String ,dynamic>, idOrganizer:id ));
        }

      if (kDebugMode) {
        print(listOrganizer.length);
      }
      return  right(listOrganizer);
    } catch (e) {
      print(e);
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }



}
