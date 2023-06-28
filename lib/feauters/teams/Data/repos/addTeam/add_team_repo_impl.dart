import 'package:crazy_fantasy/feauters/teams/Data/models/team.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'add_team_repo.dart';

class AddTeamRepoImpl implements AddTeamRepo {
  DocumentSnapshot? lastDocument;

  @override
  Future<Either<String, String>> addTeam(
      {required String id, required Team teamModel}) async {
    if (await isTeamNameTaken(id)) {
      return left("اسم فريق هذا موجود مسبقاً");
    }

    try {
      CollectionReference teams =
          FirebaseFirestore.instance.collection('teams');

      await teams.doc().set(teamModel.toMap(), SetOptions(merge: true));
      return const Right('تم اضافه الفريق بنجاح');
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> deleteTeam({required String id}) {
    // TODO: implement deleteTeam
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<Team>>> getTeams(
      {bool refrish = false, DocumentSnapshot? lastDocument}) async {
    if (refrish == true) {
      this.lastDocument = null;
    }
    try {
      List<DocumentSnapshot> documents = await getDocumentByPagination();
      List<Team> teams = [];
      for (var doc in documents) {
        var data = doc.data();
        String idDoc = doc.reference.id;
        print(idDoc);


        teams.add(Team.fromJson(data as Map<String, dynamic>,idDoc));
      }
      refrish = false;
      return Right(teams);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateTeam(
      {required String id, required Team teamModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('teams')
          .doc(id)
          .update(teamModel.toMap());
      return const Right('تم تعديل الفريق بنجاح');
    } catch (e) {
      debugPrint(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  Future<List<DocumentSnapshot>> getDocumentByPagination() async {
    if (lastDocument == null) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('teams').limit(15).get();
      lastDocument = querySnapshot.docs.last;
      return querySnapshot.docs;
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .startAfterDocument(lastDocument!)
          .limit(10)
          .get();
      lastDocument = querySnapshot.docs.last;
      return querySnapshot.docs;
    }
  }
}

Future<bool> isTeamNameTaken(String teamName) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('name', isEqualTo: teamName)
        .get();
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors here
    return false;
  }
}
