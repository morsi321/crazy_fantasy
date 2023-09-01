import 'dart:math';

import 'package:crazy_fantasy/feauters/Teams%20Data%20update/Data/repos/Properties%20Team/properties%20_team_repo_impl.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constance/url.dart';
import '../../../../core/servies/api_services.dart';
import '../../../vip/Data/repo/vip_repo_impl.dart';
import 'updateTeamsRepos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTeamsRepoImpl implements UpdateTeamsRepo {
  @override
  Future<Either<String, String>> startSeason({required Organizer org}) async {
    try {
      await OrganizeVipChampionshipRepoImpl().createVip(org: org);
      await updateNumGameWeek(idOrg: org.id!);

      return const Right('تم بداء الموسم بنجاح');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return const Left("حدث خطأ ما اثناء بداء الموسم");
    }
  }

  @override
  Future<Either<String, String>> finishGameWeek({
    required Organizer org,
  }) async {
    try {
      // int numGameWeek = await getGameWeek(idOrg: org.id!);
      // await updateTeams(
      //     idOrg: org.id!,
      //     onSendProgress: onSendProgress,
      //     numGameWeek: numGameWeek,
      //     idTeams: mergeTwoListWithOutDuplicate(
      //         org.otherChampionshipsTeams!
      //             .map((e) => e["id"] as String)
      //             .toList(),
      //         org.teams1000Id!));
      await handelChampionship(org: org);
      await updateNumGameWeek(idOrg: org.id!);

      return const Right('finishGameWeek');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Left(e.toString());
    }
  }

  handelChampionship({required Organizer org}) async {
    if (org.countTeams == "512") {
      await OrganizeVipChampionshipRepoImpl().handeVip512(org: org);
    } else if (org.countTeams == "256") {
      await OrganizeVipChampionshipRepoImpl().handeVip256(org: org);
    } else if (org.countTeams == "128") {
      await OrganizeVipChampionshipRepoImpl().handeVip128(org: org);
    }
  }

  updateTeams(
      {required String idOrg,
      required void Function(
        int countUpdate,
        int total,
      ) onSendProgress,
      required int numGameWeek,
      required List<String> idTeams}) async {
    List<DocumentSnapshot> teamsDocs = await getALLTeams(idTeams: idTeams);

    List<Map> teamScores = await getGameWeekTeamScores(
      teamsDocs,
      numGameWeek,
      idOrg,
    );
    List<Map> championsTeamOrg =
        await getChampionsTeamOrg(idOrg: idOrg, detailsTeams: teamScores);
    List<Map> newScoresOrgTeam =
        handelOrg(orgTeamsDetails: championsTeamOrg, numGameWeek: numGameWeek);
    await putResult(newScoresOrgTeam, idOrg);

    // getOrgForAllTeams();
    // await updateAllTeamsInFireBase(
    //     onSendProgress: (value) => onSendProgress(value, total));
    // await registerLastUpdate();
  }

  getGameWeek({required String idOrg}) async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('organizers')
        .doc(idOrg)
        .get();
    return data['numGameWeek'];
  }

  Future<int> getPointsGameWeek(int id, int numGameWeek) async {
    final random = Random();
    return 20 + random.nextInt(90 - 20);
  }

  getGameWeekTeamScores(
      List<DocumentSnapshot<Object?>> documents, int numGameWeek, String idOrg,
      ) async {
    List<Future> futures = [];
    List<Map> teamsScores = [];
    Stopwatch stopwatch = Stopwatch()..start();
    for (var docTeam in documents) {
      futures.add(Future(() async {
        List<int> gameWeekScore = await Future.wait([
          getPointsGameWeek(docTeam['captain'], numGameWeek),
          getPointsGameWeek(docTeam['fantasyID1'], numGameWeek),
          getPointsGameWeek(docTeam['fantasyID2'], numGameWeek),
          getPointsGameWeek(docTeam['fantasyID3'], numGameWeek),
          getPointsGameWeek(docTeam['fantasyID4'], numGameWeek),
        ]);
        teamsScores.add({
          docTeam.reference.id: {
            "gameWeekScoresTeam": gameWeekScore,
          }
        });
      }));
    }
    await Future.wait(futures);
    stopwatch.stop();
    if (kDebugMode) {
      print("time${stopwatch.elapsedMilliseconds}");
    }


    return teamsScores;
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

  Future getALLTeams({required List<String> idTeams}) async {
    List<Future> futures = [];
    List<DocumentSnapshot> teamsDocs = [];
    for (var id in idTeams) {
      futures.add(FirebaseFirestore.instance
          .collection('teams')
          .doc(id)
          .get()
          .then((value) {
        teamsDocs.add(value);
      }));
    }
    await Future.wait(futures);
    return teamsDocs;
  }

  updateNumGameWeek({required String idOrg}) async {
    try {
      return FirebaseFirestore.instance.collection("organizers").doc(idOrg).set(
          {"numGameWeek": FieldValue.increment(1)}, SetOptions(merge: true));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  handelOrg({required List<Map> orgTeamsDetails, required int numGameWeek}) {
    List<Map> newScoresOrgTeams = [];
    for (Map team in orgTeamsDetails) {
      List<String> nameChampionShips =
          team[team.keys.first]["champions"].keys.toList();

      for (var champion in nameChampionShips) {
        if (team[team.keys.first]["champions"][champion]["chosen"] ==
            "captain") {
          int doubleCaptain = PropertiesTeamRepoImpl()
              .doubleScore(scores: team[team.keys.first]["gameWeekScoresTeam"]);

          team[team.keys.first]["champions"][champion]["gameWeek"] = {
            "gameWeek$numGameWeek": {
              "score": doubleCaptain,
              "type": "doubleCaptain"
            }
          };
          team[team.keys.first]["champions"][champion]["totalPoints"] =
              team[team.keys.first]["champions"][champion]["totalPoints"] +
                  doubleCaptain;
        } else if (team[team.keys.first]["champions"][champion]["chosen"] ==
            "tripleCaptain") {
          int tripleCaptain = PropertiesTeamRepoImpl()
              .tripleScore(scores: team[team.keys.first]["gameWeekScoresTeam"]);
          team[team.keys.first]["champions"][champion]["gameWeek"] = {
            "gameWeek$numGameWeek": {
              "score": tripleCaptain,
              "type": "tripleCaptain",
            }
          };
          team[team.keys.first]["champions"][champion]["chosen"] = "captain";

          team[team.keys.first]["champions"][champion]["tripleCaptain"] = false;

          team[team.keys.first]["champions"][champion]["totalPoints"] =
              team[team.keys.first]["champions"][champion]["totalPoints"] +
                  tripleCaptain;
        } else if (team[team.keys.first]["champions"][champion]["chosen"] ==
            "maxCaptain") {
          team[team.keys.first]["champions"][champion]["chosen"] = "captain";

          int maxCaptain = PropertiesTeamRepoImpl().maximumScore(
              scores: team[team.keys.first]["gameWeekScoresTeam"]);
          team[team.keys.first]["champions"][champion]["gameWeek"] = {
            "gameWeek$numGameWeek": {"score": maxCaptain, "type": "maxCaptain"}
          };

          team[team.keys.first]["champions"][champion]["maxCaptain"] = false;
          team[team.keys.first]["champions"][champion]["totalPoints"] =
              team[team.keys.first]["champions"][champion]["totalPoints"] +
                  maxCaptain;
        }
      }
      newScoresOrgTeams.add(team);
    }
    return newScoresOrgTeams;
  }

  getChampionsTeamOrg(
      {required String idOrg, required List<Map> detailsTeams}) async {
    List<Map> orgDetailsTeam = [];
    List<Future> futures = [];

    for (var team in detailsTeams) {
      futures.add(Future(() async {
        Map<String, dynamic> org =
            await getOrg(idTeam: team.keys.first, idOrg: idOrg);
        orgDetailsTeam.add({
          team.keys.first: {
            "gameWeekScoresTeam": team[team.keys.first]["gameWeekScoresTeam"],
            "champions": org,
          }
        });
      }));
    }
    await Future.wait(futures);

    return orgDetailsTeam;
  }

// getOrgsForAllTeams(List<String> ids) async {
//   List orgs = [];
//   for (var id in ids) {
//     orgs.add(getOrg(id));
//   }
// }

  getOrg({required String idTeam, required String idOrg}) async {
    DocumentSnapshot org = await FirebaseFirestore.instance
        .collection('teams')
        .doc(idTeam)
        .collection('organizers')
        .doc(idOrg)
        .get();
    return org.data();
  }

  putResult(List<Map> newScoreOrgTeams, String nameOrg) async {
    List<Future> futures = [];
    for (var team in newScoreOrgTeams) {
      String idTeam = team.keys.first;

      futures.add(FirebaseFirestore.instance
          .collection('teams')
          .doc(idTeam)
          .collection("organizers")
          .doc(nameOrg)
          .set(team[team.keys.first]["champions"], SetOptions(merge: true)));
    }

    await Future.wait(futures);
  }

  deleteTeams() {
    FirebaseFirestore.instance.collection("teams").get().then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
  }

  mergeTwoListWithOutDuplicate(List<String> list1, List<String> list2) {
    List<String> list3 = [];
    list3.addAll(list1);
    list3.addAll(list2);
    list3 = list3.toSet().toList();
    return list3;
  }
}
