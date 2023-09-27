import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../organizers/Data/models/orgnizer_model.dart';
import 'classic_league_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizeClassicLeagueRepoImpl implements OrganizeClassicLeagueRepo {
  @override
  Future handel128Classic({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
              await doRound(
                  orgId: org.id!,
                  numRound: 64,
                  countTeams: int.parse(org.countTeams!),
                  lastNumRound: 128),
              regRound(org: org.id!, numRound: "64", name: "الدور الاقصائي")
            }
          : {};
    }else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 25) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 64, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 26) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 64, numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
        await doRound(
            orgId: org.id!,
            numRound: 16,
            countTeams: int.parse(org.countTeams!),
            lastNumRound: 64),
        regRound(org: org.id!, numRound: "16", name: "الدور النهائي")
      }
          : {};
    } else if (org.numGameWeek! >= 27 && org.numGameWeek! <= 36) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 16, numRound: org.countTeams!);
    }
  }

  @override
  Future handel256Classic({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
              await doRound(
                  orgId: org.id!,
                  numRound: 128,
                  countTeams: int.parse(org.countTeams!),
                  lastNumRound: 256),
              regRound(org: org.id!, numRound: "128", name: "الدور الاقصائي")
            }
          : {};
    }else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 25) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 128, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 26) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 128, numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
        await doRound(
            orgId: org.id!,
            numRound: 32,
            countTeams: int.parse(org.countTeams!),
            lastNumRound: 128),
        regRound(org: org.id!, numRound: "32", name: "الدور النهائي")
      }
          : {};
    } else if (org.numGameWeek! >= 27 && org.numGameWeek! <= 36) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 32, numRound: org.countTeams!);
    }
  }

  @override
  Future handel512Classic({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgId: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
              await doRound(
                  orgId: org.id!,
                  numRound: 128,
                  countTeams: int.parse(org.countTeams!),
                  lastNumRound: 512),
              regRound(org: org.id!, numRound: "128", name: "الدور الاقصائي")
            }
          : {};
    } else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 25) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 128, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 26) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 128, numRound: org.countTeams!);

      !org.isUpdateRealTime!
          ? {
              await doRound(
                  orgId: org.id!,
                  numRound: 32,
                  countTeams: int.parse(org.countTeams!),
                  lastNumRound: 128),
              regRound(org: org.id!, numRound: "32", name: "الدور النهائي")
            }
          : {};
    } else if (org.numGameWeek! >= 27 && org.numGameWeek! <= 36) {
      await finishGameWeek(
          orgId: org.id!, numGameWeek: 32, numRound: org.countTeams!);
    }
  }

  @override
  Future createClassicLeague({required Organizer org}) async {
    int countHead = 0;
    if (org.countTeams == "512") {
      countHead = 32;
    } else if (org.countTeams == "256") {
      countHead = 16;
    } else if (org.countTeams == "128") {
      countHead = 8;
    }
    (List<Map>, List<Map>) teams = await getClassicLeagueTeams(
        teamsId: org.otherChampionshipsTeams!, countHead: countHead);
    List<Map> headTeam = teams.$1;
    List<Map> othersTeam = teams.$2;

    Map groups = await divisionFirstGroup(
        othersTeams: othersTeam, teamsHead: headTeam, countHead: countHead);
    groups = removeEmptyGroup(groups);

    await addGroupsInFireStore(
        nameRound: org.countTeams!, data: groups, org: org.id!);
    regRound(org: org.id!, numRound: org.countTeams!, name: "الدور التمهيدي");
  }

  regRound(
      {required String org,
      required String numRound,
      required String name}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("classic_league")
        .doc("leagues")
        .set(
      {
        "leagues": FieldValue.arrayUnion([
          {
            "numRound": numRound,
            "name": name,
          }
        ]),
      },
      SetOptions(merge: true),
    );
  }

  finishGameWeek(
      {required String orgId,
      required int numGameWeek,
      required String numRound}) async {
    Map newResult = await selectWinner(
      org: orgId,
      numGameWeek: numGameWeek,
      numRound: numRound,
    );

    newResult = sortTeams(newResult["groups"]);

    await addGroupsInFireStore(
        data: newResult, nameRound: '$numRound', org: orgId);
  }

  sortTeams(Map scoreGroups) {
    Map sortedGroups = {};
    scoreGroups.forEach((key, value) {
      value.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
      sortedGroups[key] = value;
    });
    return sortedGroups;
  }

  selectWinner(
      {required int numGameWeek,
      required String org,
      required String numRound}) async {
    Map groups = await getRound(numRound: "$numRound", org: org);

    List<Future> futures = [];

    groups["groups"].forEach((key, group) {
      for (int i = 0; i < group.length; i++) {
        futures.add(Future(() async {
          int lastScore = 0;
          try {
            lastScore = group[i]['gameWeeks']
                .where((element) => element['numGameWeek'] == numGameWeek)
                .toList()
                .last['score'];
          } catch (_) {
            lastScore = 0;
          }

          /// delete last points
          ///

          group[i]['points'] -= lastScore;

          ///get score team a , team b
          Map team =
              await getPointsGameWeekTeam(group[i]['teamId'], numGameWeek, org);

          int score = team['score'];

          String type = team['type'];

          group[i]['gameWeeks']
              .add({"numGameWeek": numGameWeek, "score": score, "type": type});

          group[i]['points'] += score;
        }));
      }
    });
    await Future.wait(futures);
    return groups;
  }

  Future<Map> getPointsGameWeekTeam(
      String teamId, int numGameWeek, String nameOrg) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection("organizers")
        .doc(nameOrg)
        .get();

    int points = documentSnapshot["الدوري الكلاسيكي"]['gameWeek']
        ["gameWeek$numGameWeek"]["score"];
    String type = documentSnapshot["الدوري الكلاسيكي"]['gameWeek']
        ["gameWeek$numGameWeek"]["type"];
    return {
      "score": points,
      "type": type,
    };
  }

  getRound({required String numRound, required String org}) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("classic_league")
        .doc(numRound);

    Map groups = (await documentReference.get()).data() as Map;

    return groups;
  }

  Future doRound(
      {required String orgId,
      required int numRound,
      required int lastNumRound,
      required int countTeams}) async {
    Map groups = await getRound(numRound: "$lastNumRound", org: orgId);

    List<Map> qualifiedTeams = await selectQualifiedTeams(groups, countTeams);
    print(qualifiedTeams.length);
    Map newGroups = divisionGroup(qualifiedTeams);

    await addGroupsInFireStore(
        org: orgId, key: "groups", data: newGroups, nameRound: '$numRound');

    // regRound(
    //     org: orgId,
    //     numRound: "$newNumRound",
    //     name: "الدور الاقصائي",
    //     type: 'secondRound');
  }

  getClassicLeagueTeams(
      {required List<Map> teamsId, required int countHead}) async {
    List<Future> futures = [];
    List<Map> othersTeams = [];
    List<Map> teamsHead = [];
    for (Map id in teamsId) {
      futures.add(Future(() async {
        Map team = await getInfoTeam(id['id']);
        if (id['isHeading'] == true) {
          teamsHead.add(team);
        } else {
          othersTeams.add(team);
        }
      }));
    }

    await Future.wait(futures);

    if (teamsHead.length > countHead) {
      othersTeams = [...othersTeams, ...teamsHead.sublist(countHead)];
      teamsHead = teamsHead.sublist(0, countHead);
    }

    return (teamsHead, othersTeams);
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

  divisionFirstGroup({
    required List<Map> othersTeams,
    required List<Map> teamsHead,
    required int countHead,
  }) async {
    Map groups = createGroups(countHead);
    groups = addHeadTeamsInGroups(groups, teamsHead);

    int numberOfGroups = 1;
    for (var i = 0; i < othersTeams.length; i++) {
      if (groups["group$numberOfGroups"].length == 64) {
        numberOfGroups++;
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "country": othersTeams[i]['country'],
          "gameWeeks": [],
        });
      } else {
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "country": othersTeams[i]['country'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "gameWeeks": [],
        });
      }
    }

    return groups;
  }

  divisionGroup(List<Map> teams) {
    Map groups = createGroups(teams.length ~/ 64);
    int numberOfGroups = 1;
    for (var i = 0; i < teams.length; i++) {
      if (groups["group$numberOfGroups"].length == 64) {
        numberOfGroups++;
        groups["group$numberOfGroups"].add({
          "teamId": teams[i]['teamId'],
          "name": teams[i]['name'],
          "imagePath": teams[i]["imagePath"],
          "points": 0,
          "country": teams[i]['country'],
          "gameWeeks": [],
        });
      } else {
        groups["group$numberOfGroups"].add({
          "teamId": teams[i]['teamId'],
          "name": teams[i]['name'],
          "imagePath": teams[i]["imagePath"],
          "points": 0,
          "country": teams[i]['country'],
          "gameWeeks": [],
        });
      }
    }

    return groups;
  }

  Map createGroups(int countTeam) {
    Map groups = {};
    for (var i = 1; i <= countTeam; i++) {
      groups["group$i"] = [];
    }
    return groups;
  }

  addHeadTeamsInGroups(
    Map groups,
    List<Map> teamsHead,
  ) {
    for (int i = 0; i < teamsHead.length; i++) {
      groups['group${i + 1}'].add({
        "teamId": teamsHead[i]['id'],
        "name": teamsHead[i]['name'],
        "imagePath": teamsHead[i]['path'].split('/').last,
        "points": 0,
        "country": teamsHead[i]['country'],
        "gameWeeks": [],
      });
    }
    return groups;
  }

  // Future groupDivision({
  //   required List<String> teamsId,
  // }) async {
  //   int numberOfTeamsInGroup = 32;
  //   clearGroups();
  //   try {
  //     for (var i = 0; i < teamsId.length; i++) {
  //       if (i < numberOfTeamsInGroup) {
  //         groups["group${numberOfTeamsInGroup ~/ 32}"]
  //             .add({"teamId": teamsId[i], "lastTotalPoints": 0});
  //       } else {
  //         numberOfTeamsInGroup += 32;
  //         groups["group${numberOfTeamsInGroup ~/ 32}"]
  //             .add({"teamId": teamsId[i], "lastTotalPoints": 0});
  //       }
  //     }
  //     Map newGroups = removeEmptyGroup(groups);
  //     return newGroups;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }

  addGroupsInFireStore(
      {required data,
      required String nameRound,
      String? key,
      required String org}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("classic_league")
        .doc(nameRound)
        .set({
      key ?? "groups": data,
    });
  }

  /////////////////////////////////////////////////////////////////////////

  selectQualifiedTeams(Map scoreGroups, int countTeams,
      {bool lastRound = false}) async {
    int countQualifiedTeams = 32;
    if (countTeams == 512) {
      countQualifiedTeams = 16;
    } else if (lastRound) {
      countQualifiedTeams = 16;
    }

    List<Map> sortedGroups = [];
    scoreGroups["groups"].forEach((key, value) {
      var sortedTeams = List<Map<String, dynamic>>.from(value)
        ..sort((a, b) => b['points'].compareTo(a['points']));
      sortedTeams.take(countQualifiedTeams).forEach((element) {
        sortedGroups.add(element);
      });
    });

    return sortedGroups;
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

  // getGroupsLastRound({required String nameRound}) async {
  //   int numberOfTeamsInGroup = 32;
  //   try {
  //     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //         .collection("Crazy_fantasy")
  //         .doc("classic_league")
  //         .collection("classic_league")
  //         .doc(nameRound)
  //         .get();
  //
  //     int count = 0;
  //     int numLoops = 0;
  //     if (nameRound == 'الدور 16') {
  //       numLoops = 512;
  //     } else if (nameRound == 'الدور 8') {
  //       numLoops = 256;
  //     } else if (nameRound == 'الدور 4') {
  //       numLoops = 128;
  //     } else if (nameRound == 'الدور 2') {
  //       numLoops = 64;
  //     } else if (nameRound == 'الدور 1') {
  //       numLoops = 32;
  //     }
  //
  //     for (var i = 0; i < numLoops; i++) {
  //       if (i < numberOfTeamsInGroup) {
  //         groups["group${numberOfTeamsInGroup ~/ 32}"].add(
  //             documentSnapshot["groups"]["group${numberOfTeamsInGroup ~/ 32}"]
  //                 [count]["teamId"]);
  //       } else {
  //         numberOfTeamsInGroup += 32;
  //         count = 0;
  //
  //         groups["group${numberOfTeamsInGroup ~/ 32}"].add(
  //             documentSnapshot["groups"]["group${numberOfTeamsInGroup ~/ 32}"]
  //                 [count]["teamId"]);
  //       }
  //       count++;
  //     }
  //
  //     return groups;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }

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

  // clearGroups() {
  //   groups.forEach((key, value) {
  //     groups[key] = [];
  //   });
  // }

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
