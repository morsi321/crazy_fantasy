import 'dart:math';

import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'cup_reop.dart';

class OrganizeCupChampionshipRepoImpl implements OrganizeCupChampionshipRepo {
  @override
  Future handeCup128({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 4) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 5) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 64, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "128", name: "الدور الاقصائي الثاني")
      };
    } else if (org.numGameWeek! >= 6 && org.numGameWeek! <= 9) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 10) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 32, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "64", name: "الدور الاقصائي الثالث")
      };
    } else if (org.numGameWeek! >= 11 && org.numGameWeek! <= 14) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 15) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 16, orgId: org.id!),

        regRound(
            org: org.id!, numRound: "32", name: "الدور الاقصائي الرابع")
      };
    } else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 19) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 20) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 8, orgId: org.id!),
        regRound(org: org.id!, numRound: "8", name: "الدور ثمن النهائي")
      };
    } else if (org.numGameWeek! >= 21 && org.numGameWeek! <= 24) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 25) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 4, orgId: org.id!),
        regRound(org: org.id!, numRound: "4", name: "الدور ربع النهائي")
      };
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 29) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 30) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 2, orgId: org.id!),
        regRound(org: org.id!, numRound: "2", name: "الدور نصف النهائي")
      };
    } else if (org.numGameWeek! >= 31 && org.numGameWeek! <= 35) {
      finishGameWeek(
          numRound: 2, orgId: org.id!, numGameWeek: org.numGameWeek!);
    }
  }

  @override
  Future handeCup256({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 4) {
      finishGameWeek(
          numRound: 256, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 5) {
      finishGameWeek(
          numRound: 256, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 128, orgId: org.id!),

        regRound(
            org: org.id!, numRound: "128", name: "الدور الاقصائي الثاني"
        )
      };
    } else if (org.numGameWeek! >= 6 && org.numGameWeek! <= 9) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 10) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 64, orgId: org.id!),

        regRound(
            org: org.id!, numRound: "64", name: "الدور الاقصائي الثالث")
      };
    } else if (org.numGameWeek! >= 11 && org.numGameWeek! <= 14) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 15) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 32, orgId: org.id!),

        regRound(
            org: org.id!, numRound: "32", name: "الدور الاقصائي الرابع")
      };
    } else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 19) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 20) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 16, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "16", name: "الدور الاقصائي الرابع")
      };
    } else if (org.numGameWeek! >= 21 && org.numGameWeek! <= 24) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 25) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 8, orgId: org.id!),

        regRound(org: org.id!, numRound: "8", name: "الدور ثمن النهائي")
      };
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 29) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 30) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 4, orgId: org.id!),

        regRound(org: org.id!, numRound: "4", name: "الدور ربع النهائي")
      };
    } else if (org.numGameWeek! >= 31 && org.numGameWeek! <= 32) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 33) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 2, orgId: org.id!),

        regRound(org: org.id!, numRound: "2", name: "الدور نصف النهائي")
      };
    } else if (org.numGameWeek! >= 34 && org.numGameWeek! <= 36) {
      finishGameWeek(
          numRound: 2, orgId: org.id!, numGameWeek: org.numGameWeek!);
    }
  }

  @override
  Future handeCup512({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 4) {
      finishGameWeek(
          numRound: 512, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 5) {
      finishGameWeek(
          numRound: 512, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 256, orgId: org.id!),

        regRound(
            org: org.id!, numRound: "256", name: "الدور الاقصائي الثاني")
      };
    } else if (org.numGameWeek! >= 6 && org.numGameWeek! <= 9) {
      finishGameWeek(
          numRound: 256, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 10) {
      finishGameWeek(
          numRound: 256, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 128, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "128", name: "الدور الاقصائي الثالث")
      };
    } else if (org.numGameWeek! >= 11 && org.numGameWeek! <= 14) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 15) {
      finishGameWeek(
          numRound: 128, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime!
          ? null
          : {
        doRound(numRound: 64, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "64", name: "الدور الاقصائي الرابع")
      };
    } else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 19) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 20) {
      finishGameWeek(
          numRound: 64, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : {
        doRound(numRound: 32, orgId: org.id!),
      };
    } else if (org.numGameWeek! >= 21 && org.numGameWeek! <= 24) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 25) {
      finishGameWeek(
          numRound: 32, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : {
        doRound(numRound: 16, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "32", name: "الدور الاقصائي الخامس")
      };
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 27) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 28) {
      finishGameWeek(
          numRound: 16, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : {
        doRound(numRound: 8, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "8", name: "الدور ثمن النهائي")
      };
    } else if (org.numGameWeek! >= 29 && org.numGameWeek! <= 30) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 31) {
      finishGameWeek(
          numRound: 8, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : {
        doRound(numRound: 4, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "4", name: "الدور ربع النهائي")
      };
    } else if (org.numGameWeek! >= 32 && org.numGameWeek! <= 33) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek == 34) {
      finishGameWeek(
          numRound: 4, orgId: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : {
        doRound(numRound: 2, orgId: org.id!),
        regRound(
            org: org.id!, numRound: "2", name: "الدور نصف النهائ")
      };
    } else if (org.numGameWeek == 35 || org.numGameWeek == 36) {
      finishGameWeek(
          numRound: 2, orgId: org.id!, numGameWeek: org.numGameWeek!);
    }
  }

  @override
  Future<Either<String, String>> createCup({required Organizer org}) async {
    try {
      List<Map> teams =
      await getCupLeagueTeams(teamsId: org.otherChampionshipsTeams!);

      teams = shuffleTeams(teams);
      Map matches = divisionOfMatches(teams);

      await addMatchesInFireStore(
          matches: matches, nameRound: org.countTeams!, org: org.id!);

      regRound(
        org: org.id!,
        numRound: org.countTeams!,
        name: "الدور الاقصائي الاول",
      );
      return right("تم انشاء بطولة VIP بنجاح");
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  regRound({required String org,
    required String numRound,
    required String name}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("cup_league")
        .doc("leagues")
        .set(
      {
        "leagues": FieldValue.arrayUnion([
          {"numRound": numRound, "name": name}
        ]),
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<Either<String, String>> doRound(
      {required int numRound, required String orgId}) async {
    try {
      Map matches =
      await getMatchesLastRound(nameRound: '${numRound * 2}', orgId: orgId);

      List<Map> teams = await qualifiedTeams(matches);
      teams = shuffleTeams(teams);
      Map newMatches = divisionOfMatches(teams, isFirstRound: false);
      await addMatchesInFireStore(
          matches: newMatches, nameRound: '$numRound', org: orgId);

      return right("تم تنظيم الدور $numRound بنجاح");
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  finishGameWeek({required int numRound,
    required String orgId,
    required int numGameWeek}) async {
    Map matches =
    await getMatchesLastRound(nameRound: '$numRound', orgId: orgId);
    await chooseWinnerTheGameWeek(
        matches: matches, nameOrg: orgId, numGameWeek: numGameWeek);
    await addMatchesInFireStore(
        matches: matches, nameRound: '$numRound', org: orgId);
  }

  getCupLeagueTeams({required List<Map> teamsId}) async {
    List<Future> futures = [];
    List<Map> dataTeams = [];
    for (Map id in teamsId) {
      futures.add(Future(() async {
        Map team = await getInfoTeam(id['id']);
        dataTeams.add(team);
      }));
    }

    await Future.wait(futures);

    return dataTeams;
  }

  getInfoTeam(String idTeam) async {
    try {
      DocumentSnapshot documentReference = await FirebaseFirestore.instance
          .collection("teams")
          .doc(idTeam)
          .get();
      Map team = documentReference.data() as Map;
      team["id"] = documentReference.reference.id;

      return team;
    } catch (e) {
      DocumentSnapshot documentReference = await FirebaseFirestore.instance
          .collection("teams")
          .doc(idTeam)
          .get();
      Map team = documentReference.data() as Map;
      team["id"] = documentReference.reference.id;

      return team;
    }
  }

  divisionOfMatches(List<Map> teams, {bool isFirstRound = true}) {
    Map matches = {
      'matches': [],
    };
    int numMatches = teams.length ~/ 2;
    for (int i = 0; i < numMatches; i++) {
      matches['matches'].add({
        "countryA": teams[i]['country'],
        "countryB": teams[numMatches + i]['country'],
        "gameWeekA": [],
        "gameWeekB": [],
        'nameA': teams[i]['name'],
        'nameB': teams[numMatches + i]['name'],
        'imageTeamA': isFirstRound ? teams[i]['path']
            .split('/')
            .last : teams[i]['imagePath'],
        'imageTeamB': isFirstRound ? teams[numMatches + i]['path']
            .split('/')
            .last : teams[numMatches + i]['imagePath'],
        'teamA': teams[i][isFirstRound?'id':'teamId'],
        'teamB': teams[numMatches + i][isFirstRound?'id':'teamId'],
        'teamGoalsA': 0,
        'teamGoalsB': 0,
      });
    }
    return matches;
  }

  chooseWinnerTheGameWeek({required Map matches,
    required String nameOrg,
    required numGameWeek}) async {
    List<Future> futures = [];

    matches['matches'].forEach((match) {
      futures.add(Future(() async {
        // delete last score
        int scoreALast = 0;
        int scoreBLast = 0;
        try {
          scoreALast = match['gameWeekA']
              .where((element) => element['numGameWeek'] == numGameWeek)
              .toList()
              .last['score'];
          scoreBLast = match['gameWeekB']
              .where((element) => element['numGameWeek'] == numGameWeek)
              .toList()
              .last['score'];
        } catch (_) {
          scoreALast = 0;
          scoreBLast = 0;
        }

        if (scoreALast > scoreBLast) {
          match['teamGoalsA'] = match['teamGoalsA'] - 1;
        } else if (scoreALast < scoreBLast) {
          match['teamGoalsB'] = match['teamGoalsB'] - 1;
        }

        Map teamA =
        await getPointsGameWeekTeam(match['teamA'], numGameWeek, nameOrg);
        Map teamB =
        await getPointsGameWeekTeam(match["teamB"], numGameWeek, nameOrg);
        int scoreA = teamA['score'];
        int scoreB = teamB['score'];

        match['gameWeekA']
            .removeWhere((element) => element["numGameWeek"] == numGameWeek);

        match['gameWeekA'].add({
          "numGameWeek": numGameWeek,
          "score": scoreA,
          "type": teamA['type'],
        });

        match['gameWeekB']
            .removeWhere((element) => element["numGameWeek"] == numGameWeek);
        match['gameWeekB'].add({
          "numGameWeek": numGameWeek,
          "score": scoreB,
          "type": teamB['type'],
        });

        if (scoreA > scoreB) {
          match['teamGoalsA'] = match['teamGoalsA'] + 1;

        } else if (scoreA < scoreB) {
          match['teamGoalsB'] = match['teamGoalsB'] + 1;
        }
      }));
    });
    await Future.wait(futures);

    return matches;
  }

  Future<Map> getPointsGameWeekTeam(String teamId, int numGameWeek,
      String nameOrg) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection("organizers")
        .doc(nameOrg)
        .get();

    int points =
    documentSnapshot["كأس الاقصائي"]['gameWeek']["gameWeek$numGameWeek"]["score"];
    String type =
    documentSnapshot["كأس الاقصائي"]['gameWeek']["gameWeek$numGameWeek"]["type"];
    return {
      "score": points,
      "type": type,
    };
  }

  qualifiedTeams(Map matches,) async {
    List<Future> futures = [];

    List<Map> qualifiedTeams = [];

    matches['matches'].forEach((match) async {
      futures.add(Future(() async {
        int score1 = match["teamGoalsA"];
        int score2 = match["teamGoalsB"];

        if (score1 > score2) {
          qualifiedTeams.add(
            {
              "teamId": match['teamA'],
              'name': match['nameA'],
              'imagePath': match['imageTeamA'],
              'country': match['countryA'],
            },
          );
        } else {
          qualifiedTeams.add({
            "teamId": match['teamB'],
            'name': match['nameB'],
            'imagePath': match['imageTeamB'],
            'country': match['countryB'],
          });
        }
      }));
    });

    await Future.wait(futures);

    return qualifiedTeams;
  }

  addMatchesInFireStore({required matches,
    required String nameRound,
    required String org}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("cup_league")
        .doc(nameRound)
        .set({
      "matches": matches["matches"],
    });
  }

  getTotalPointsTeam(String teamId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("teams")
          .doc(teamId)
          .get();
      return documentSnapshot['totalScore'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<T> shuffleTeams<T>(List<T> teams) {
    Random random = Random();

    for (int i = teams.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      T temp = teams[i];
      teams[i] = teams[j];
      teams[j] = temp;
    }
    // print(teams);

    return teams;
  }

  getMatchesLastRound({
    required String nameRound,
    required String orgId,
  }) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("organizers")
        .doc(orgId)
        .collection("cup_league")
        .doc(nameRound);
    Map matches = (await documentReference.get()).data() as Map;
    return matches;
  }
}
