import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'vip_repo.dart';

class OrganizeVipChampionshipRepoImpl implements OrganizeVipChampionshipRepo {
  Map groups = {};

  @override
  Future<Either<String, String>> createVip() async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Map> teams = await getVipLeagueTeams();
      teams = shuffleTeams(teams);
      Map groupWithMatches = await groupDivision(teams: teams);
      Map<dynamic, dynamic> matches = matchesDivision(groupWithMatches);
      Map half1Group = halfGroups(matches).$1;
      Map half2Group = halfGroups(matches).$2;

      await addGroupsInFireStore(data: half1Group, nameRound: 'الدور 511');

      await addGroupsInFireStore(data: half2Group, nameRound: 'الدور 512');
      await updateNumGameWeek(firstGameWeek: true);

      stopwatch.stop();
      if (kDebugMode) {
        print('time: ${stopwatch.elapsedMilliseconds}');
      }

      return const Right('تم انشاء البطولة بنجاح');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return const Left("حدث خطأ ما برجاء المحاولة مرة اخري");
    }
  }

  @override
  Future<Either<String, String>> doRound256() async {
    Map half1 = await getRound(numRound: 511);
    Map half2 = await getRound(numRound: 512);

    Map mergeGroups = merge2Groups(half1["groups"], half2["groups"]);

    Map qualifiedTeams = await selectQualifiedTeams(mergeGroups);
    Map matches = matchesDivisionCross(qualifiedTeams);

    await addGroupsInFireStore(
        key: "matches", data: matches["matches"], nameRound: 'الدور 256');
    await updateNumGameWeek();

    try {
      return const Right("تم تنظيم الدور 256 بنجاح");
    } catch (e) {
      return const Left(" حدث خطأ ما برجاء المحاولة مرة اخري");
    }
  }

  @override
  Future<Either<String, String>> doRound({required int numRound}) async {
    try {
      Map matches = await getRound(numRound: numRound * 2);
      List<Map> teams128 = await qualifiedTeams(matches);
      teams128 = shuffleTeams(teams128);
      Map matchesRandom = await divisionOfMatchesRandom(teams128);
      await addGroupsInFireStore(
          key: "matches",
          data: matchesRandom["matches"],
          nameRound: 'الدور $numRound');

      return const Right("تم تنظيم الدور 256 بنجاح");
    } catch (e) {
      print(e.toString());
      return const Left(" حدث خطأ ما برجاء المحاولة مرة اخري");
    }
  }

  @override
  Future<Either<String, String>> doRound8() async {
    try {
      Map matches = await getRound(numRound: 16);
      List<Map> teams8 = await qualifiedTeams(matches);
      individuallyDivisionMatches(teams8);
      await addGroupsInFireStore(
        key: "individuallyTeams",
        data: teams8,
        nameRound: 'الدور 8',
      );

      return const Right("تم تنظيم الدور 8 بنجاح");
    } catch (e) {
      return const Left(" حدث خطأ ما برجاء المحاولة مرة اخري");
    }
  }

  @override
  getCurrentGameWeek() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("vip_league")
          .get();
      int numGameWeek = documentSnapshot['gameWeek'];
      return Right(numGameWeek);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  merge2Groups(Map group1, Map group2) {
    Map mergeGroups = {};
    for (int i = 1; i <= 32; i++) {
      if (i <= 16) {
        mergeGroups['group$i'] = group1['group$i'];
      } else {
        mergeGroups['group$i'] = group2['group$i'];
      }
    }
    return mergeGroups;
  }

  halfGroups(Map group) {
    Map half1Group = {};
    Map half2Group = {};
    for (int i = 1; i <= group.length; i++) {
      if (i <= group.length / 2) {
        half1Group['group$i'] = group['group$i'];
      } else {
        half2Group['group$i'] = group['group$i'];
      }
    }
    return (half1Group, half2Group);
  }

  individuallyDivisionMatches(List<Map> teams) {
    for (var team in teams) {
      team['matches'] = [];
      team['points'] = 0;
    }

    List<Map> matches = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams.length; j++) {
        if (i == j) continue;
        matches.add({
          "homeTeam": teams[i]['id'],
          "awayTeam": teams[j]['id'],
          "nameHomeTeam": teams[i]['name'],
          "nameAwayTeam": teams[j]['name'],
          "image2": teams[j]['imagePath'],
          "image1": teams[i]['imagePath'],
          "homeTeamGoals": 0,
          "awayTeamGoals": 0,
          "isFinished": false,
        });
      }
      teams[i]['matches'] = matches;
      matches = [];
    }

    return teams;
  }

  divisionOfMatchesRandom(List<Map> teams) {
    Map matches = {
      'matches': [],
    };
    int numMatches = teams.length ~/ 2;
    for (int i = 0; i < numMatches; i++) {
      matches['matches'].add({
        'nameTeamA': teams[i]['name'],
        'nameTeamB': teams[numMatches + i]['name'],
        'imageTeamA': teams[i]['imagePath'],
        'imageTeamB': teams[numMatches + i]['imagePath'],
        'teamAId': teams[i]['id'],
        'teamBId': teams[numMatches + i]['id'],
        'teamAGoals': 0,
        'teamBGoals': 0,
      });
    }
    return matches;
  }

  qualifiedTeams(
    Map matches,
  ) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future> futures = [];

      List<Map> qualifiedTeams = [];

      matches['matches'].forEach((match) async {
        futures.add(Future(() async {
          int score1 = match["teamAGoals"];
          int score2 = match["teamBGoals"];

          if (score1 > score2) {
            qualifiedTeams.add(
              {
                "id": match['teamAId'],
                'name': match['nameTeamA'],
                'imagePath': match['imageTeamA']
              },
            );
          } else if (score1 < score2) {
            qualifiedTeams.add({
              "id": match['teamBId'],
              'name': match['nameTeamB'],
              'imagePath': match['imageTeamB']
            });
          }
        }));
      });

      await Future.wait(futures);

      stopwatch.stop();
      if (kDebugMode) {
        print('doRound2 executed in ${stopwatch.elapsedMilliseconds} ms');
      }
      return qualifiedTeams;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  finishGameWeekInRound({required int numRound}) async {
    Map matches = await getRound(numRound: numRound);

    await regScores(matches: matches, increment: 3);

    await addGroupsInFireStore(
        data: matches['matches'], nameRound: "الدور $numRound", key: "matches");
    await updateNumGameWeek();

    // regScores(matches)
  }

  regScores({required Map matches, required int increment}) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future> futures = [];

      matches['matches'].forEach((match) {
        // print(match);
        futures.add(Future(() async {
          int score1 = await getTotalPointsTeam(match['teamAId']);
          int score2 = await getTotalPointsTeam(match["teamBId"]);

          if (score1 > score2) {
            match['teamAGoals'] = match['teamAGoals'] + increment;
            match['teamBGoals'] = 0;
          } else if (score1 < score2) {
            match['teamAGoals'] = 0;
            match['teamBGoals'] = match['teamBGoals'] + increment;
          } else {
            if (increment == 3) {
              match['teamAGoals'] = match['teamAGoals'] + 1;
              match['teamBGoals'] = match['teamBGoals'] + 1;
            } else {
              match['teamAGoals'] = match['teamAGoals'] - 1;
              match['teamBGoals'] = match['teamBGoals'] - 1;
            }
          }
        }));
      });
      await Future.wait(futures);

      stopwatch.stop();
      if (kDebugMode) {
        print('doRound2 executed in ${stopwatch.elapsedMilliseconds} ms');
      }
      return matches;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getVipLeagueTeams() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('isVipLeague', isEqualTo: true)
          .get();
      List<DocumentSnapshot> teamsDoc = querySnapshot.docs;
      List<Map> teams = teamsDoc
          .map(
            (snapshot) => {
              "id": snapshot.id,
              'name': snapshot['name'],
              'imagePath': snapshot['path']
            },
          )
          .toList();
      return teams;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }

  groupDivision({
    required List<Map> teams,
  }) async {
    int numberOfTeamsInGroup = 16;
    createGroups();
    try {
      for (var i = 0; i < teams.length; i++) {
        if (i < numberOfTeamsInGroup) {
          groups["group${numberOfTeamsInGroup ~/ 16}"].add({
            "teamId": teams[i]['id'],
            "name": teams[i]['name'],
            "imagePath": teams[i]['imagePath'],
            "points": 0,
            "matches": [],
          });
        } else {
          numberOfTeamsInGroup += 16;
          groups["group${numberOfTeamsInGroup ~/ 16}"].add({
            "teamId": teams[i]['id'],
            "name": teams[i]['name'],
            "imagePath": teams[i]['imagePath'],
            "points": 0,
            "matches": [],
          });
        }
      }
      // Map newGroups = removeEmptyGroup(groups);

      return groups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  matchesDivisionCross(Map groups) {
    Map matches = {
      'matches': [],
    };

    for (int i = 1; i <= 32; i += 2) {
      for (int k = 0; k < groups['group${33 - i}'].length; k++) {
        matches['matches'].add({
          "teamAId": groups['group$i'][k]['teamId'],
          "teamBId": groups['group${i + 1}'][7 - k]['teamId'],
          "nameTeamA": groups['group$i'][k]['name'],
          "nameTeamB": groups['group${i + 1}'][7 - k]['name'],
          'imageTeamA': groups['group$i'][k]['imagePath'],
          'imageTeamB': groups['group${i + 1}'][7 - k]['imagePath'],
          "teamAGoals": 0,
          "teamBGoals": 0,
          "isFinished": false,
        });
      }
    }
    return matches;
  }

  matchesDivision(Map teams) {
    Stopwatch stopwatch = Stopwatch()..start();
    List<Map> matches = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams["group${i + 1}"].length; j++) {
        for (int k = 0; k < teams["group${i + 1}"].length; k++) {
          if (j == k) {
            continue;
          }
          matches.add({
            "homeTeam": teams["group${i + 1}"][j]['teamId'],
            "awayTeam": teams["group${i + 1}"][k]['teamId'],
            "nameHomeTeam": teams["group${i + 1}"][j]['name'],
            "nameAwayTeam": teams["group${i + 1}"][k]['name'],
            "image2": teams["group${i + 1}"][k]['imagePath'].split('/').last,
            "homeTeamGoals": 0,
            "awayTeamGoals": 0,
            "isFinished": false,
          });
        }
        teams["group${i + 1}"][j]['matches'] = matches;
        matches = [];
      }
    }
    // print(teams["group2"][1]['matches']);

    stopwatch.stop();
    print('matchesDivision executed in ${stopwatch.elapsedMilliseconds}');

    return teams;
  }

  selectQualifiedTeams(Map scoreGroups) {
    try {
      Map sortedGroups = {};
      scoreGroups.forEach((key, value) {
        value
            .sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
        sortedGroups[key] = value.take(8).toList();
      });
      return sortedGroups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    // sortedGroups now holds the sorted groups
  }

  getRound({required int numRound}) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("vip_league")
          .collection("vip_rounds")
          .doc("الدور $numRound");

      Map groups = (await documentReference.get()).data() as Map;

      return groups;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  finishGameWeek() async {
    try {
      int numGameWeek = await getLastGameWeek() - 1;
      Map newResult = await selectWinner(
        numGameWeek: numGameWeek,
      );
      var result = halfGroups(newResult);
      Map half1Group = result.$1;
      Map half2Group = result.$2;
      await addGroupsInFireStore(data: half1Group, nameRound: 'الدور 511');

      await addGroupsInFireStore(data: half2Group, nameRound: 'الدور 512');
      await updateNumGameWeek();
      return const Right("تم انهاء الجولة بنجاح");
    } catch (e) {
      return const Left("جدث خطأ ما حاول مرة اخرى");
    }
  }

  finishGameWeeKInLastRound() async {
    int numGameWeek = await getLastGameWeek();
    numGameWeek = 38 - numGameWeek;
    List newResult =
        await setResultGameWeekInLastRound(numGameWeek: numGameWeek);
    await updateNumGameWeek();
    await addGroupsInFireStore(
        key: 'individuallyTeams', data: newResult, nameRound: 'الدور 8');
  }

  setResultGameWeekInLastRound({required int numGameWeek}) async {
    Map dataRound = await getRound(numRound: 8);
    List teams = dataRound['individuallyTeams'];

    numGameWeek = 7 - numGameWeek;
    print(numGameWeek);

    List<Future> futures = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams[i]['matches'].length; j++) {
        if (j == numGameWeek) {
          futures.add(Future(() async {
            int scoreHomeTeam =
                await getTotalPointsTeam(teams[i]['matches'][j]['homeTeam']);
            int scoreAwayTeam =
                await getTotalPointsTeam(teams[i]['matches'][j]['awayTeam']);

            if (scoreHomeTeam > scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['homeTeamGoals'] = 3;
              teams[i]['matches'][numGameWeek]['awayTeamGoals'] = 0;
            } else if (scoreHomeTeam < scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['homeTeamGoals'] = 0;
              teams[i]['matches'][numGameWeek]['awayTeamGoals'] = 3;
            } else {
              teams[i]['matches'][numGameWeek]['homeTeamGoals'] = 1;
              teams[i]['matches'][numGameWeek]['awayTeamGoals'] = 1;
            }
            teams[i]['matches'][numGameWeek]['isFinished'] = true;
            teams[i]['points'] +=
                teams[i]['matches'][numGameWeek]['homeTeamGoals'];
          }));
          // group[i]['points'] += totalPoints;
        }
      }
    }
    await Future.wait(futures);
    return teams;
  }
 @override
  removeFirstGameWeek() async {
  try{
    int numGameWeek = await getLastGameWeek() - 2;
    Map newResult = await selectWinner(numGameWeek: numGameWeek, remove: true);
    var result = halfGroups(newResult);
    Map half1Group = result.$1;
    Map half2Group = result.$2;
    await addGroupsInFireStore(data: half1Group, nameRound: 'الدور 511');

    await addGroupsInFireStore(data: half2Group, nameRound: 'الدور 512');
    updateNumGameWeek(deleteGameWeek: true);
    return const Right("تم  حذف الجولة بنجاح");

  } catch(e){
    if(kDebugMode){
      print(e.toString());
    }
    return const Left("حدث خطأ ما حاول مرة اخرى");
  }

  }

  selectWinner({required int numGameWeek, bool remove = false}) async {
    Map half1 = await getRound(numRound: 511);
    Map half2 = await getRound(numRound: 512);
    Map merge2Group = merge2Groups(half1['groups'], half2['groups']);

    List<Future> futures = [];

    merge2Group.forEach((key, group) {
      for (int i = 0; i < group.length; i++) {
        for (int j = 0; j < group[i]['matches'].length; j++) {
          if (j == numGameWeek) {
            futures.add(Future(() async {
              int scoreHomeTeam =
                  await getTotalPointsTeam(group[i]['matches'][j]['homeTeam']);
              int scoreAwayTeam =
                  await getTotalPointsTeam(group[i]['matches'][j]['awayTeam']);

              if (scoreHomeTeam > scoreAwayTeam) {
                group[i]['matches'][numGameWeek]['homeTeamGoals'] =
                    remove ? 0 : 3;
                group[i]['matches'][numGameWeek]['awayTeamGoals'] = 0;

                group[i]['points'] += remove
                    ? -3
                    : group[i]['matches'][numGameWeek]['homeTeamGoals'];
              } else if (scoreHomeTeam < scoreAwayTeam) {
                group[i]['matches'][numGameWeek]['homeTeamGoals'] = 0;
                group[i]['matches'][numGameWeek]['awayTeamGoals'] =
                    remove ? 0 : 3;
              } else {
                group[i]['matches'][numGameWeek]['homeTeamGoals'] =
                    remove ? 0 : 1;
                group[i]['matches'][numGameWeek]['awayTeamGoals'] =
                    remove ? 0 : 1;
                group[i]['points'] += remove
                    ? -1
                    : group[i]['matches'][numGameWeek]['homeTeamGoals'];
              }
              group[i]['matches'][numGameWeek]['isFinished'] = remove ? false : true;
            }));
          }
        }
      }
    });
    await Future.wait(futures);
    return merge2Group;
  }

  addGroupsInFireStore(
      {required data, required String nameRound, String? key}) async {
    try {
      FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("vip_league")
          .collection("vip_rounds")
          .doc(nameRound)
          .set({
        "isFinished": false,
        key ?? "groups": data,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  updateNumGameWeek(
      {bool deleteGameWeek = false, bool firstGameWeek = false}) async {
    try {
      DocumentReference fire = FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("vip_league");
      if (firstGameWeek) {
        fire.set({
          "gameWeek": FieldValue.increment(1),
        });
      } else {
        fire.update({
          "gameWeek": FieldValue.increment(deleteGameWeek ? -1 : 1),
        });
      }
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

  getLastGameWeek() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("vip_league")
          .get();
      // print(documentSnapshot['totalScore']);
      return documentSnapshot['gameWeek'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
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

  void createGroups() {
    for (var i = 1; i <= 32; i++) {
      groups["group$i"] = [];
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
}
