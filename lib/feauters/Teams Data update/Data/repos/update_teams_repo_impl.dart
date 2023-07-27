import 'dart:math';

import 'package:crazy_fantasy/feauters/Teams%20Data%20update/Data/repos/Properties%20Team/properties%20_team_repo_impl.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constance/url.dart';
import '../../../../core/servies/api_services.dart';
import '../../../vip/Data/repo/vip_repo_impl.dart';
import 'organizers/OrganizersRepoImpl.dart';
import 'updateTeamsRepos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTeamsRepoImpl implements UpdateTeamsRepo {
  List<Map> gameWeeksAndTotalPoints = [];
  int countUpdate = 1;
  int total = 0;

  @override
  Future<Either<String, String>> startSeason() async {
    try {
      List<String> organizers =
          await OrganizersRepoImpl().getNameAllOrganizers();
      List<Future> futures = [
        OrganizersRepoImpl().addOrganizersInTeams(),
      ];
      for (var org in organizers) {
        futures.add(OrganizeVipChampionshipRepoImpl().createVip(org: org));
      }

      await Future.wait(futures);
      await updateNumGameWeek(isFirst: true);

      return const Right('تم بداء الموسم بنجاح');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return const Left("حدث خطأ ما اثناء بداء الموسم");
    }
  }

  @override
  Future<Either<String, String>> finishGameWeek(
      {required void Function(int countUpdate, int total)
          onSendProgress}) async {
    try {
      await updateNumGameWeek();

      int numGameWeek = await getGameWeek();
      await updateTeams(
          onSendProgress: onSendProgress, numGameWeek: numGameWeek);
      await championshipVip(numGameWeek);

      return const Right('finishGameWeek');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Left(e.toString());
    }
  }

  championshipVip(int numGameWeek) async {
    try {
      List<String> organizers =
          await OrganizersRepoImpl().getNameAllOrganizers();
      List<Future> futures = [];
      for (var org in organizers) {
        futures.add(OrganizeVipChampionshipRepoImpl()
            .handeVip(gameWeek: numGameWeek, org: org));
      }
      await Future.wait(futures);
      if (kDebugMode) {
        print("done");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  updateTeams({
    required void Function(int countUpdate, int total) onSendProgress,
    required int numGameWeek,
  }) async {
    try {
      List<DocumentSnapshot> teamsDocs = await getALLTeams();

      total = teamsDocs.length * 2;

      await fetchDoc(teamsDocs, numGameWeek,
          onSendProgress: (value) => onSendProgress(value, total));
      await updateAllTeamsInFireBase(
          onSendProgress: (value) => onSendProgress(value, total));
      await registerLastUpdate();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  fetchDoc(List<DocumentSnapshot<Object?>> documents, int numGameWeek,
      {required void Function(int countUpdate) onSendProgress}) async {
    try {
      List<Future> futures = [];
      Stopwatch stopwatch = Stopwatch()..start();
      for (var doc in documents) {
        futures.add(
            getGameWeekTeam(doc, numGameWeek, onSendProgress: onSendProgress));
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

  getGameWeek() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('infoApp')
        .doc('gameWeek')
        .get();
    int gameWeek;
    if (data.exists) {
      gameWeek = data['gameWeek'];
      return gameWeek;
    } else {
      gameWeek = 909;
      return gameWeek;
    }
  }

  @override
  Future<Either<String, int>> getCurrentGameWeek() async {
    try {
      int gameWeek = await getGameWeek();
      print(gameWeek);
      return Right(gameWeek);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<int> getPointsGameWeek(int id, int numGameWeek) async {
    final random = Random();
    return 20 + random.nextInt(90 - 20);
  }

  getGameWeekTeam(DocumentSnapshot docTeam, int numGameWeek,
      {required void Function(
        int countUpdate,
      ) onSendProgress}) async {
    List<int> gameWeekScore = await Future.wait([
      getPointsGameWeek(docTeam['captain'], numGameWeek),
      getPointsGameWeek(docTeam['fantasyID1'], numGameWeek),
      getPointsGameWeek(docTeam['fantasyID2'], numGameWeek),
      getPointsGameWeek(docTeam['fantasyID3'], numGameWeek),
      getPointsGameWeek(docTeam['fantasyID4'], numGameWeek),
    ]);

    int tripleCaptain =
        PropertiesTeamRepoImpl().tripleScore(scores: gameWeekScore);
    int doubleCaptain =
        PropertiesTeamRepoImpl().doubleScore(scores: gameWeekScore);
    int maxCaptain =
        PropertiesTeamRepoImpl().maximumScore(scores: gameWeekScore);

    gameWeeksAndTotalPoints.add({
      'idTeam': docTeam.reference.id,
      "data": {
        "gameWeek$numGameWeek": {
          "tripleCaptain": tripleCaptain,
          "doubleCaptain": doubleCaptain,
          "maxCaptain": maxCaptain,
        },
        "totalScore": docTeam['totalScore'] +
            (gameWeekScore[0]) * 2 +
            gameWeekScore[1] +
            gameWeekScore[2] +
            gameWeekScore[3] +
            gameWeekScore[4],
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

  updateAllTeamsInFireBase(
      {required void Function(
        int countUpdate,
      ) onSendProgress}) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future> futures = [];

      CollectionReference fire = FirebaseFirestore.instance.collection('teams');

      for (var team in gameWeeksAndTotalPoints) {
        futures.add(fire
            .doc(
              team["idTeam"],
            )
            .update(team['data']));
        onSendProgress(
          countUpdate++,
        );
      }

      // await Future.wait(futures);
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

  updateNumGameWeek({bool isFirst = false}) async {
    try {
      DocumentReference fire =
          FirebaseFirestore.instance.collection("infoApp").doc("gameWeek");
      if (isFirst) {
        fire.set({"gameWeek": 0});
      } else {
        fire.update({
          "gameWeek": FieldValue.increment(1),
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
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
      if (docLastUpdate.exists) {
        return right(docLastUpdate['lastUpdate']);
      } else {
        return right(" لم يتم تحديث البيانات من قبل");
      }
    } catch (e) {
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }
}
