import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'classic_league_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizeClassicLeagueRepoImpl implements OrganizeClassicLeagueRepo {
  Map<String, dynamic> groups = {
    "group1": [],
    "group2": [],
    "group3": [],
    "group4": [],
    "group5": [],
    "group6": [],
    "group7": [],
    "group8": [],
    "group9": [],
    "group10": [],
    "group11": [],
    "group12": [],
    "group13": [],
    "group14": [],
    "group15": [],
    "group16": [],
  };

  @override
  Future<Either<String, String>> createClassicLeague() async {
    try {
      List<String> teamsId = await getClassicLeagueTeams();
      teamsId = shuffleTeams(teamsId);
      Map groups = await groupDivision(teamsId: teamsId);

      await addGroupsInFireStore(groups: groups, nameRound: 'الدور 16');

      return right("تم تنظيم الدور الاول بنجاح");
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, String>> doRound({required int numRound}) async {
    try {
      Map groups = await getGroupsLastRound(nameRound: 'الدور ${numRound*2}');
      Map scoreGroups = await getScoresTeam(groups);

      await finishLastRound(
          groups: scoreGroups, nameRound: 'الدور ${numRound*2}');
      List<String> qualifiedTeams = selectQualifiedTeams(scoreGroups);

      qualifiedTeams = shuffleTeams(qualifiedTeams);

      Map groupsRound2 = await groupDivision(teamsId: qualifiedTeams);
      print(groupsRound2.length);
      await addGroupsInFireStore(
          groups: groupsRound2, nameRound: 'الدور $numRound');
      return right(" تم تنظيم $numRound بنجاح ");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  Future getClassicLeagueTeams() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('isClassicLeague', isEqualTo: true)
          .get();
      List<DocumentSnapshot> teams = querySnapshot.docs;
      List<String> teamIds = teams.map((snapshot) => snapshot.id).toList();
      return teamIds;
    } catch (e) {
      return e.toString();
    }
  }

  Future groupDivision({
    required List<String> teamsId,
  }) async {
    int numberOfTeamsInGroup = 32;
    clearGroups();
    try {
      for (var i = 0; i < teamsId.length; i++) {
        if (i < numberOfTeamsInGroup) {
          groups["group${numberOfTeamsInGroup ~/ 32}"]
              .add({"teamId": teamsId[i], "lastTotalPoints": 0});
        } else {
          numberOfTeamsInGroup += 32;
          groups["group${numberOfTeamsInGroup ~/ 32}"]
              .add({"teamId": teamsId[i], "lastTotalPoints": 0});
        }
      }
      Map newGroups = removeEmptyGroup(groups);
      return newGroups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  addGroupsInFireStore({required Map groups, required String nameRound}) async {
    try {
      FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("classic_league")
          .collection("classic_league")
          .doc(nameRound)
          .set({
        "isFinished": false,
        "groups": groups,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /////////////////////////////////////////////////////////////////////////

  selectQualifiedTeams(Map scoreGroups) {
    try {
      // sort map scoreGroups by value totalPoints

      Map sortedGroups = {};
      scoreGroups.forEach((key, value) {
        var sortedTeams = List<Map<String, dynamic>>.from(value)
          ..sort((a, b) => b['totalPoints'].compareTo(a['totalPoints']));
        sortedGroups[key] = sortedTeams.take(16);
      });

      // select qualified 16 teams
      List<String> qualifiedTeams = [];
      sortedGroups.forEach((key, value) {
        value.forEach((element) {
          qualifiedTeams.add(element["teamId"]);
        });
      });

      return qualifiedTeams;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /////////////////////////////////////////////////////////////////////////
  finishLastRound({required Map groups, required String nameRound}) {
    try {
      FirebaseFirestore.instance
          .collection("classic_league")
          .doc(nameRound)
          .set({
        "isFinished": true,
        "groups": groups,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /////////////////////////////////////////////////////////////////////////

  getGroupsLastRound({required String nameRound}) async {
    int numberOfTeamsInGroup = 32;
    try {
      DocumentSnapshot documentSnapshot = await  FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("classic_league")
          .collection("classic_league")
          .doc(nameRound).get();


      int count = 0;
      int numLoops = 0;
      if (nameRound == 'الدور 16') {
        numLoops = 512;
      } else if (nameRound == 'الدور 8') {
        numLoops = 256;
      } else if (nameRound == 'الدور 4') {
        numLoops = 128;
      } else if (nameRound == 'الدور 2') {
        numLoops = 64;
      } else if (nameRound == 'الدور 1') {
        numLoops = 32;
      }

      for (var i = 0; i < numLoops; i++) {
        if (i < numberOfTeamsInGroup) {
          groups["group${numberOfTeamsInGroup ~/ 32}"].add(
              documentSnapshot["groups"]["group${numberOfTeamsInGroup ~/ 32}"]
                  [count]["teamId"]);
        } else {
          numberOfTeamsInGroup += 32;
          count = 0;

          groups["group${numberOfTeamsInGroup ~/ 32}"].add(
              documentSnapshot["groups"]["group${numberOfTeamsInGroup ~/ 32}"]
                  [count]["teamId"]);
        }
        count++;
      }

      return groups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //////////////////////////////////////////////////////////////////

  getScoresTeam(Map groupsId) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future<void>> futures = [];
      Map<String, dynamic> scoreGroups = {
        "group1": [],
        "group2": [],
        "group3": [],
        "group4": [],
        "group5": [],
        "group6": [],
        "group7": [],
        "group8": [],
        "group9": [],
        "group10": [],
        "group11": [],
        "group12": [],
        "group13": [],
        "group14": [],
        "group15": [],
        "group16": [],
      };

      for (int i = 0; i < groupsId.length; i++) {
        for (int j = 0; j < groupsId["group${i + 1}"].length; j++) {
          futures.add(Future(() async {
            int totalPoints =
                await getTotalPointsTeam(groupsId["group${i + 1}"][j]);
            scoreGroups["group${i + 1}"].add({
              "teamId": groupsId["group${i + 1}"][j],
              "totalPoints": totalPoints
            });
          }));
        }
      }

      await Future.wait(futures);
      Map newScoreGroups = removeEmptyGroup(scoreGroups);

      stopwatch.stop();
      if (kDebugMode) {
        print('doRound2 executed in ${stopwatch.elapsedMilliseconds} ms');
      }
      return newScoreGroups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getTotalPointsTeam(String teamId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("teams")
          .doc(teamId)
          .get();
      // print(documentSnapshot['totalScore']);
      return documentSnapshot['totalScore'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

//

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

  clearGroups() {
    groups.forEach((key, value) {
      groups[key] = [];
    });
  }

  removeEmptyGroup(Map<dynamic, dynamic> groups) {
    Map newGroups = {};
    groups.forEach((key, value) {
      if (value.isNotEmpty) {
        newGroups[key] = value;
      }
    });

    return newGroups;
  }
}
