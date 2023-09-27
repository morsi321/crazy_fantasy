import 'dart:math';

import 'package:crazy_fantasy/feauters/Classic%20League/Data/repos/classic_league_repo_impl.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/Data/repos/Properties%20Team/properties%20_team_repo_impl.dart';
import 'package:crazy_fantasy/feauters/open_champion/Data/open_champion_repo_impl.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constance/url.dart';
import '../../../../core/servies/api_services.dart';
import '../../../Cup/Data/repos/cup_reop_impl.dart';
import '../../../vip/Data/repo/vip_repo_impl.dart';
import 'updateTeamsRepos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTeamsRepoImpl implements UpdateTeamsRepo {
  @override
  Future<Either<String, String>> startSeason({required Organizer org}) async {
    List<Future> futures = [];
    try {
      futures = [
        OrganizeClassicLeagueRepoImpl().createClassicLeague(org: org),
        OrganizeVipChampionshipRepoImpl().createVip(org: org),
        OrganizeCupChampionshipRepoImpl().createCup(org: org),
        OpenChampionRepoImpl().CreateOpenChampion(org: org),
      ];
      await Future.wait(futures);
      // await closeUpdate(idOrg: org.id!);
      //
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
      await updateTeams(
          isRealTimeUpdate: org.isUpdateRealTime,
          idOrg: org.id!,
          numGameWeek: org.numGameWeek!,
          idTeams: mergeTwoListWithOutDuplicate(
              org.otherChampionshipsTeams!
                  .map((e) => e["id"] as String)
                  .toList(),
              org.teams1000Id!));
      await handelChampionship(
        org: org,
      );
      !org.isUpdateRealTime! ? await updateNumGameWeek(idOrg: org.id!) : () {};

      return const Right('finishGameWeek');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Left(e.toString());
    }
  }

  closeUpdate({required idOrg}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(idOrg)
        .set({"isCloseUpdate": true}, SetOptions(merge: true));
  }

  handelChampionship({
    required Organizer org,
  }) async {
    List<Future> futures = [];
    if (org.countTeams == "512") {
      futures = [
        OrganizeClassicLeagueRepoImpl().handel512Classic(org: org),
        OpenChampionRepoImpl().FinishGameWeek(org: org),
        OrganizeVipChampionshipRepoImpl().handeVip512(org: org),
        OrganizeCupChampionshipRepoImpl().handeCup512(org: org)
      ];
    } else if (org.countTeams == "256") {
      futures = [
        OrganizeClassicLeagueRepoImpl().handel256Classic(org: org),
        OpenChampionRepoImpl().FinishGameWeek(org: org),
        OrganizeVipChampionshipRepoImpl().handeVip256(org: org),
        OrganizeCupChampionshipRepoImpl().handeCup256(org: org)
      ];
    } else if (org.countTeams == "128") {
      futures = [
      OrganizeClassicLeagueRepoImpl().handel128Classic(org: org),
        OpenChampionRepoImpl().FinishGameWeek(org: org),
        OrganizeVipChampionshipRepoImpl().handeVip128(org: org),
        OrganizeCupChampionshipRepoImpl().handeCup128(org: org)
      ];
    }
    await Future.wait(futures);
  }

  updateTeams(
      {required String idOrg,
      required int numGameWeek,
      required isRealTimeUpdate,
      required List<String> idTeams}) async {
    List<Map> teamsDocs = await getALLTeams(idTeams: idTeams, idOrg: idOrg);

    List<Map> championsTeams = await getGameWeekTeamScores(
      teamsDocs,
      numGameWeek,
      idOrg,
    );
    List<Map> newScoresOrgTeam = handelOrg(
        orgTeamsDetails: championsTeams,
        numGameWeek: numGameWeek,
        isRealTimeUpdate: isRealTimeUpdate);

    await putResult(newScoresOrgTeam, idOrg);
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

  getScoresFirstChampion(List teamFirstChampionships, int numGameWeek) async {
    List<Map> scores = [];
    List<Future> futures = [];
    for (int i = 0; i < 5; i++) {
      futures.add(Future(() async {
        scores.add({
          "id": teamFirstChampionships[i]["id"],
          "score": await getPointsGameWeek(
              teamFirstChampionships[i]["id"], numGameWeek)
        });
      }));
    }
    await Future.wait(futures);

    return scores;
  }

  Future<List<Map>> getGameWeekTeamScores(
    List<Map> documents,
    int numGameWeek,
    String idOrg,
  ) async {
    List<Future> futures = [];

    for (Map docTeam in documents) {
      final champ = docTeam[docTeam.keys.first];
      List<Map> scores = await getScoresFirstChampion(
          champ[champ.keys.first]["team"], numGameWeek);
      List<Future> teamFutures = [];

      champ.forEach((key, value) async {
        final team = value["team"];
        for (int i = 0; i < 5; i++) {
          try {
            team[i]["score"] = scores.firstWhere(
                (element) => element["id"] == value["team"][i]["id"])["score"];
          } catch (e) {
            team[i]["score"] =
                await getPointsGameWeek(team[i]["id"], numGameWeek);
            print(team[i]["score"]);
          }
        }
      });

      futures.addAll(teamFutures);
    }

    await Future.wait(futures);
    return documents;
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

  Future getALLTeams(
      {required List<String> idTeams, required String idOrg}) async {
    List<Future> futures = [];
    List<Map> teamsDocs = [];
    for (var id in idTeams) {
      futures.add(FirebaseFirestore.instance
          .collection('teams')
          .doc(id)
          .collection("organizers")
          .doc(idOrg)
          .get()
          .then((value) => teamsDocs.add({id: value.data() as Map})));
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

  handelOrg(
      {required List<Map> orgTeamsDetails,
      required int numGameWeek,
      required bool isRealTimeUpdate}) {
    for (Map champion in orgTeamsDetails) {
      final champ = champion[champion.keys.first];
      champ.forEach((key, value) {
        if (value["chosen"] == "captain") {
          value["totalPoints"] -=
              value["gameWeek"]["gameWeek$numGameWeek"]?["score"] ?? 0;
          int doubleCaptain =
              PropertiesTeamRepoImpl().doubleScore(scores: value["team"]);

          value["gameWeek"]["gameWeek$numGameWeek"] = {
            "score": doubleCaptain,
            "type": "doubleCaptain"
          };

          value["totalPoints"] = value["totalPoints"] + doubleCaptain;
        } else if (value["chosen"] == "tripleCaptain") {
          value["totalPoints"] -=
              value["gameWeek"]["gameWeek$numGameWeek"]?["score"] ?? 0;
          if (!isRealTimeUpdate) {
            value["tripleCaptain"] = false;
            value["chosen"] = "captain";
          }

          int tripleCaptain =
              PropertiesTeamRepoImpl().tripleScore(scores: value["team"]);

          value["gameWeek"]["gameWeek$numGameWeek"] = {
            "score": tripleCaptain,
            "type": "tripleCaptain",
          };

          value["totalPoints"] = value["totalPoints"] + tripleCaptain;
        } else if (value["chosen"] == "maxCaptain") {
          value["totalPoints"] -=
              value["gameWeek"]["gameWeek$numGameWeek"]?["score"] ?? 0;
          if (isRealTimeUpdate) {
            value["maxCaptain"] = false;
            value["chosen"] = "captain";
          }

          int maxCaptain =
              PropertiesTeamRepoImpl().maximumScore(scores: value["team"]);
          value["gameWeek"]["gameWeek$numGameWeek"] = {
            "score": maxCaptain,
            "type": "maxCaptain"
          };

          value["totalPoints"] = value["totalPoints"] + maxCaptain;
        } else if (value["chosen"] == "guestPlayer") {
          value["totalPoints"] -=
              value["gameWeek"]["gameWeek$numGameWeek"]?["score"] ?? 0;
          if (isRealTimeUpdate) {
            value["guestPlayer"] = false;
            value["chosen"] = "captain";
          }

          int guestPlayer =
              PropertiesTeamRepoImpl().doubleScore(scores: value["team"]);
          value["gameWeek"] = {"score": guestPlayer, "type": "maxCaptain"};

          value["gameWeek"]["gameWeek$numGameWeek"] = {
            "score": guestPlayer,
            "type": "guestPlayer"
          };

          value["totalPoints"] = value["totalPoints"] + guestPlayer;

          for (int i = 0; i < 5; i++) {
            if (value["team"][i]["id"] == value["team"][5]["id"]) {
              value["team"][i]["id"] = value["team"][6]["id"];
            }
          }
        } else if (value["chosen"] == "freeMinus") {
          value["totalPoints"] -=
              value["gameWeek"]["gameWeek$numGameWeek"]?["score"] ?? 0;
          if (isRealTimeUpdate) {
            value["freeMinus"] = false;
            value["chosen"] = "captain";
          }

          int freeMinus =
              PropertiesTeamRepoImpl().freeScore(scores: value["team"]);
          value["gameWeek"]["gameWeek$numGameWeek"] = {
            "score": freeMinus,
            "type": "freeMinus"
          };

          value["totalPoints"] = value["totalPoints"] + freeMinus;
        }
      });
    }
    return orgTeamsDetails;
  }

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
    Stopwatch stopwatch = Stopwatch()..start();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: false);
    WriteBatch writeBatch = firestore.batch();
    for (Map team in newScoreOrgTeams) {
      String idTeam = team.keys.first;

      writeBatch.set(
        firestore
            .collection('teams')
            .doc(idTeam)
            .collection("organizers")
            .doc(nameOrg),
        team[team.keys.first],
      );
    }
    await writeBatch.commit();

    // await Future.wait(futures);
    stopwatch.stop();
    print('finish putResult ${stopwatch.elapsedMilliseconds}');
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
