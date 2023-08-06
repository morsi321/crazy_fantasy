import 'package:crazy_fantasy/core/constance/url.dart';
import 'package:crazy_fantasy/core/models/team.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/servies/api_services.dart';
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
  }

  @override
  Future<Either<String, String>> deleteTeam({required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(id).delete();
      return const Right('تم حذف الفريق بنجاح');
    } catch (e) {
      debugPrint(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, List<Team>>> getTeams(
      {bool refrish = false, DocumentSnapshot? lastDocument}) async {
    if (refrish == true) {
      this.lastDocument = null;
    }
    try {
      List<DocumentSnapshot> documents = [];
      documents = await getDocumentByPagination();
      List<Team> teams = fetchDoc(documents);
      refrish = false;
      return Right(teams);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Left(e.toString());
    }
  }

  fetchDoc(List<DocumentSnapshot<Object?>> documents) {
    List<Team> teams = [];
    for (var doc in documents) {
      var data = doc.data();
      String idDoc = doc.reference.id;

      teams.add(Team.fromJson(data as Map<String, dynamic>, idDoc));
    }
    return teams;
  }

  @override
  Future<Either<String, String>> updateTeam(
      {required String id, required Team teamModel}) async {
    try {
      CollectionReference fire = FirebaseFirestore.instance.collection('teams');

      await fire.doc(id).update(teamModel.toMap());
      return const Right('تم تعديل الفريق بنجاح');
    } catch (e) {
      debugPrint(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  Future<List<DocumentSnapshot>> getDocumentByPagination() async {
    if (lastDocument == null) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('teams').limit(50).get();
      lastDocument = querySnapshot.docs.last;
      return querySnapshot.docs;
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .startAfterDocument(lastDocument!)
          .limit(50)
          .get();

      lastDocument = querySnapshot.docs.last;
      return querySnapshot.docs;
    }
  }

  @override
  Future<Either<String, List<Team>>> search(String nameTeam) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where("name", isGreaterThanOrEqualTo: nameTeam)
          .where("name", isLessThanOrEqualTo: "$nameTeam\uf7ff")
          .get();
      List<Team> teams = fetchDoc(querySnapshot.docs);
      // print(teams[0].name);
      return Right(teams);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return const Left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future getScorePlayer(int id) async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> responce =
          await apiService.get(path: UrlEndpoint.getScoreHistory(id));
      int score = responce['past'][0]['total_points'];
      try {
        return score;
      } catch (e) {
        return 0;
      }
    } catch (e) {
      return getScorePlayer(id);
    }
  }
}

getScoreTeam() async {}

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
