import 'package:crazy_fantasy/core/models/team.dart';
import 'package:crazy_fantasy/feauters/teams/Data/repos/addTeam/add_team_repo_impl.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constance/url.dart';
import '../../../../core/servies/api_services.dart';
import 'updateTeamsRepos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTeamsRepoImpl implements UpdateTeamsRepo {
  Map teamsJson = {"teams": []};
  int countUpdate = 1;
  int total = 0;

  @override
  Future<Either<String, String>> updateTeams(
      {required void Function(int countUpdate, int total)
          onSendProgress}) async {
    try {
      List<DocumentSnapshot> teamsDocs = await getALLTeams();
      total = teamsDocs.length * 2;
      await fetchDoc(teamsDocs,
          onSendProgress: (value) => onSendProgress(value, total));
      await updateAllTeamsInFireBase(
          onSendProgress: (value) => onSendProgress(value, total));
      await registerLastUpdate();

      return right("تم تحديث البيانات بنجاح");
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  fetchDoc(List<DocumentSnapshot<Object?>> documents,
      {required void Function(int countUpdate) onSendProgress}) async {
    try {
      List<Future> futures = [];
      Stopwatch stopwatch = Stopwatch()..start();
      for (var doc in documents) {
        futures.add(getScoreTeam(doc, onSendProgress: onSendProgress));
      }
      if (kDebugMode) {
        print(futures.length);
      }
      await Future.wait(futures);
      stopwatch.stop();
      if (kDebugMode) {
        print('threads time: ${stopwatch.elapsedMilliseconds} ms');
      }
    } catch (e) {
      print(e);
    }
  }

  getScoreTeam(DocumentSnapshot docTeam,
      {required void Function(
        int countUpdate,
      ) onSendProgress}) async {
    List<int> scoresTeam = await Future.wait([
      getScorePlayer(docTeam['captain']),
      getScorePlayer(docTeam['fantasyID1']),
      getScorePlayer(docTeam['fantasyID2']),
      getScorePlayer(docTeam['fantasyID3']),
      getScorePlayer(docTeam['fantasyID4']),
    ]);
    if (kDebugMode) {
      print(scoresTeam);
    }
    teamsJson['teams']!.add({
      'idTeam': docTeam.reference.id,
      "team": {
        "scoreCaptain": scoresTeam[0],
        "scoreFantasyID1": scoresTeam[1],
        "scoreFantasyID2": scoresTeam[2],
        "scoreFantasyID3": scoresTeam[3],
        "scoreFantasyID4": scoresTeam[4],
        "totalScore": (scoresTeam[0]) * 2 +
            scoresTeam[1] +
            scoresTeam[2] +
            scoresTeam[3] +
            scoresTeam[4],
      }
    });

    onSendProgress(
      countUpdate++,
    );
  }

  Future<int> getScorePlayer(int id) async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> response =
          await apiService.get(path: UrlEndpoint.getScoreHistory(id));
      try {
        return response['past'][0]['total_points'];
      } catch (e) {
        return 0;
      }
      return response['past'][0]['total_points'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return getScorePlayer(id);
    }
  }

  Future getALLTeams() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('teams').get();
      // await FirebaseFirestore.instance.collection('teams').where(FieldPath.documentId, isNotEqualTo: 'lastUpdate').get();

      return querySnapshot.docs;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /*Future<void> updateAllItemsInFireBaseByBitch() async {
    try {
      Stopwatch stopwatch = Stopwatch()
        ..start();
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var team in teamsJson['teams']!) {
        batch.update(team["idTeam"], team['team']);
      }

      await batch.commit().then((value) => print("updated"));
      stopwatch.stop();
      if (kDebugMode) {
        print('bitch time: ${stopwatch.elapsedMilliseconds} ms');
      }
    } catch (e) {
      print(e.toString());
    }
  }*/

  updateAllTeamsInFireBase(
      {required void Function(
        int countUpdate,
      ) onSendProgress}) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();

      CollectionReference fire = FirebaseFirestore.instance.collection('teams');

      List<Future> futures = [];
      for (var team in teamsJson['teams']!) {
        fire
            .doc(
              team["idTeam"],
            )
            .update(team['team']);
        onSendProgress(
          countUpdate++,
        );
      }

      await Future.wait(futures);
      if (kDebugMode) {
        print("updated");
      }
      stopwatch.stop();
      if (kDebugMode) {
        print('bitch time: ${stopwatch.elapsedMilliseconds} ms');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  registerLastUpdate() async {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    String formattedTime =
        '${(now.hour % 12).toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour < 12 ? 'AM' : 'PM'}';

    String lastUpdate = "$formattedDate   $formattedTime";
    if (kDebugMode) {
      print(lastUpdate);
    }

    await FirebaseFirestore.instance
        .collection('infoApp')
        .doc('lastUpdate')
        .update({"lastUpdate": lastUpdate});
  }

  @override
  Future<Either<String, String>> getLastUpdate() async {
    try {
      DocumentSnapshot docLastUpdate = await FirebaseFirestore.instance
          .collection('infoApp')
          .doc('lastUpdate')
          .get();
      return right(docLastUpdate['lastUpdate']);
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
    throw UnimplementedError();
  }
}
