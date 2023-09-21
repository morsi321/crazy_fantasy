import 'package:crazy_fantasy/core/models/team.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'add_team_repo.dart';

class AddTeamRepoImpl implements AddTeamRepo {
  DocumentSnapshot? lastDocument;

  @override
  Future<Either<String, String>> addTeam(
      {required String id, required Team teamModel}) async {
    if (await isTeamNameTaken(teamModel.name!)) {
      return left("اسم فريق هذا موجود مسبقاً");
    }

    try {
      CollectionReference teams =
          FirebaseFirestore.instance.collection('teams');

      await teams.doc(id).set(teamModel.toMap(), SetOptions(merge: true));
      return const Right('تم اضافه الفريق بنجاح');
    } catch (e) {
      print("error");
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, String>> deleteTeam({required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(id).delete();
      await deleteTeamIdFromUserCaptain(idUser: id);
      return const Right('تم حذف الفريق بنجاح');
    } catch (e) {
      debugPrint(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, List<Team>>> getTeams() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .orderBy('name')
          .get();
      List<Team> teams = fetchDoc(querySnapshot.docs);

      return Right(teams);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Left(e.toString());
    }
  }

  fetchDoc(List<DocumentSnapshot<Object?>> documents) {
    List<Team> teams = documents.map((doc) {
      var data = doc.data();
      String idDoc = doc.reference.id;
      return Team.fromJson(data as Map<String, dynamic>, idDoc);
    }).toList();

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

  // Future<List<DocumentSnapshot>> getDocumentByPagination() async {
  //   if (lastDocument == null) {
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('teams').limit(50).get();
  //     lastDocument = querySnapshot.docs.last;
  //     return querySnapshot.docs;
  //   } else {
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('teams')
  //         .startAfterDocument(lastDocument!)
  //         .limit(50)
  //         .get();
  //
  //     lastDocument = querySnapshot.docs.last;
  //     return querySnapshot.docs;
  //   }
  // }

  // Future getScorePlayer(int id) async {
  //   try {
  //     ApiService apiService = ApiService();
  //     Map<String, dynamic> responce =
  //         await apiService.get(path: UrlEndpoint.getScoreHistory(id));
  //     int score = responce['past'][0]['total_points'];
  //     try {
  //       return score;
  //     } catch (e) {
  //       return 0;
  //     }
  //   } catch (e) {
  //     return getScorePlayer(id);
  //   }
  // }
// }

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

  getUserName(String idUser) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(idUser).get();
    return data['name'];
  }

  @override
  Future<Either<String, String>> addLeaderForTeam(
      {required String idUser,
      required teamId,
      required String lastIdLeader}) async {
    try {
      if(idUser==""){
        return left("برجاء ادخال id القائد");
      }
      bool check = await checkLeaderIsFound(idUser);

      if(idUser == lastIdLeader){
        return left("لا يمكنك تسجيل نفس القائد مرتين هذا القائد مسجل بالفعل لهذا الفريق");
      }
      if (check) {
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection('users')
            .doc(idUser)
            .get();
        if (data['teamId'] != "") {
          String nameTeam = await getNameTeam(data['teamId']);

          return Left(
              "  لقد تم تسجيل هذا القائد ${data["name"]} لفريق  اسمه " +
                  nameTeam +
                  " " +
                  "برجاء  تعديله حتي تتمكن من اضافه قائد جديد");
        } else {

          List<Future> futures = [
            lastIdLeader != ""
                ? deleteTeamIdFromUserCaptain(idUser: lastIdLeader)
                : Future.value(),
            regTeamIdInUserCaptain(idUser: idUser, teamId: teamId),
            regLeaderIdInTeam(idUser: idUser, teamId: teamId)
          ];
          await Future.wait(futures);

          String name = await getUserName(idUser);

          return Right("تم تسجيل الفريق بنجاح لقائد اسمه " + name );
        }
      } else {
        return left("لا يوجد قائد بهذا id");
      }
    } catch (e) {
      print(e);
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  regTeamIdInUserCaptain({required String idUser, required teamId}) async {
    FirebaseFirestore.instance.collection('users').doc(idUser).set({
      "teamId": teamId,
    }, SetOptions(merge: true));
    print("regTeamIdInUserCaptain");
  }

  deleteTeamIdFromUserCaptain({
    required String idUser,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(idUser).set({
      "teamId": "",
    }, SetOptions(merge: true));
  }

  checkLeaderIsFound(String idLeader) async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(idLeader)
        .get();
    if (data.exists) {
      return true;
    } else {
      return false;
    }
  }

  regLeaderIdInTeam({required String idUser, required teamId}) async {
    FirebaseFirestore.instance.collection('teams').doc(teamId).set({
      "managerID": idUser,
    }, SetOptions(merge: true));
  }

  getNameTeam(String idTeam) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('teams').doc(idTeam).get();
    return data['name'];
  }
}
