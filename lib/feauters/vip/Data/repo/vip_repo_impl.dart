import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../organizers/Data/models/orgnizer_model.dart';
import 'vip_repo.dart';

class OrganizeVipChampionshipRepoImpl implements OrganizeVipChampionshipRepo {
  @override
  Future handeVip512({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
      org.isUpdateRealTime!
          ? null
          : await doSecondRound(org: org.id!, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 16) {
      await finishGameWeekInRound(
          numRound: 256, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 17) {
      await finishGameWeekInRound(
          numRound: 256, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 128, org: org.id!);
    } else if (org.numGameWeek! == 18) {
      await finishGameWeekInRound(
          numRound: 128, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 19) {
      await finishGameWeekInRound(
          numRound: 128, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 64, org: org.id!);
    } else if (org.numGameWeek! == 20) {
      await finishGameWeekInRound(
          numRound: 64, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 21) {
      await finishGameWeekInRound(
          numRound: 64, org: org.id!, numGameWeek: org.numGameWeek!);

      org.isUpdateRealTime! ? null : await doRound(numRound: 32, org: org.id!);
    } else if (org.numGameWeek! == 22) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 23) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 16, org: org.id!);
    } else if (org.numGameWeek! == 24) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 25) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 34) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      org.isUpdateRealTime! ? null : await doRound(numRound: 2, org: org.id!);
    } else if (org.numGameWeek! == 35 || org.numGameWeek! == 36) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 2);
    }
  }

  @override
  Future handeVip256({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
      org.isUpdateRealTime!
          ? null
          : await doSecondRound(org: org.id!, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 16 || org.numGameWeek! == 17) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 128,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 18) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 128,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 64, org: org.id!);
    } else if (org.numGameWeek! == 19 || org.numGameWeek! == 20) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 64,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 21) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 64,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 32, org: org.id!);
    } else if (org.numGameWeek! == 22) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 23) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 16, org: org.id!);
    } else if (org.numGameWeek! == 24) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 25) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 34) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      org.isUpdateRealTime! ? null : await doRound(numRound: 2, org: org.id!);
    } else if (org.numGameWeek! == 35 || org.numGameWeek! == 36) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 2);
    }
  }

  @override
  Future handeVip128({required Organizer org}) async {
    if (org.numGameWeek! >= 1 && org.numGameWeek! <= 14) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
    } else if (org.numGameWeek! == 15) {
      await finishGameWeek(
          orgName: org.id!,
          numGameWeek: org.numGameWeek!,
          numRound: org.countTeams!);
      org.isUpdateRealTime!
          ? null
          : await doSecondRound(org: org.id!, numRound: org.countTeams!);
    } else if (org.numGameWeek! >= 16 && org.numGameWeek! <= 17) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 64,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 18) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 64,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 32, org: org.id!);
    } else if (org.numGameWeek! == 19 || org.numGameWeek! == 20) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 32,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 21) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 32,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound(numRound: 16, org: org.id!);
    } else if (org.numGameWeek! == 22 || org.numGameWeek! == 23) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 16,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 24) {
      await finishGameWeekInRound(
          isBestOf3: true,
          numRound: 16,
          org: org.id!,
          numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 25 && org.numGameWeek! <= 30) {
      await finishGameWeeKInLastRound(
          isVip128: true, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      org.isUpdateRealTime! ? null : await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      org.isUpdateRealTime! ? null : await doRound(numRound: 2, org: org.id!);
    } else if (org.numGameWeek! == 34 || org.numGameWeek! == 35) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 2);
    }
  }

  @override
  Future createVip({required Organizer org}) async {
    String numRound1 = '';
    String numRound2 = '';
    String numRound3 = '';
    String numRound4 = '';
    int countHead = 0;
    if (org.countTeams == "512") {
      numRound1 = '512-1';
      numRound2 = '512-2';
      numRound3 = '512-3';
      numRound4 = '512-4';
      countHead = 32;
    } else if (org.countTeams == "256") {
      numRound1 = '256-1';
      numRound2 = '256-2';
      numRound3 = '256-3';
      numRound4 = '256-4';
      countHead = 16;
    } else if (org.countTeams == "128") {
      numRound1 = '128-1';
      numRound2 = '128-2';
      numRound3 = '128-3';
      numRound4 = '128-4';
      countHead = 8;
    }

    (List<Map>, List<Map>) teams = await getVipLeagueTeams(
        teamsId: org.otherChampionshipsTeams!, countHead: countHead);
    List<Map> headTeam = teams.$1;
    List<Map> othersTeam = teams.$2;

    Map groupWithMatches = await groupDivision(
        othersTeams: othersTeam, teamsHead: headTeam, countHead: countHead);
    Map<dynamic, dynamic> matches = matchesDivision(groupWithMatches);
    var groups = fourGroups(matches);

    List<Future> futures = [
      addGroupsInFireStore(
          data: groups["1"], nameRound: numRound1, org: org.id!),
      addGroupsInFireStore(
          data: groups["2"], nameRound: numRound2, org: org.id!),
      addGroupsInFireStore(
          data: groups["3"], nameRound: numRound3, org: org.id!),
      addGroupsInFireStore(
          data: groups["4"], nameRound: numRound4, org: org.id!)
    ];

    await Future.wait(futures);
    regRound(
        org: org.id!,
        numRound: org.countTeams!,
        name: "دور المجموعات",
        type: 'firstRound');
  }

  @override
  Future doSecondRound({required String org, required String numRound}) async {
    List<Future> futures = [
      getRound(numRound: "$numRound-1", org: org),
      getRound(numRound: "$numRound-2", org: org),
      getRound(numRound: "$numRound-3", org: org),
      getRound(numRound: "$numRound-4", org: org),
    ];

    var rounds = await Future.wait(futures);

    Map mergeGroups = merge4Groups(
        group1: rounds[0]["groups"],
        group2: rounds[1]["groups"],
        group3: rounds[2]["groups"],
        group4: rounds[3]["groups"]);

    Map qualifiedTeams = await selectQualifiedTeams(mergeGroups);
    Map matches = matchesDivisionCross(qualifiedTeams);
    int newNumRound = int.parse(numRound) ~/ 2;

    await addGroupsInFireStore(
        org: org,
        key: "matches",
        data: matches["matches"],
        nameRound: '$newNumRound');

    regRound(
        org: org,
        numRound: "$newNumRound",
        name: "الدور الاقصائي",
        type: 'secondRound');
  }

  doRound4({required int numRound, required String org}) async {
    Map matches = await getRound(numRound: "${numRound * 2}", org: org);

    List qualifiedTeams = await selectQualifiedTeamsInLastRound(matches);
    List<Map> teams = [];
    for (var team in qualifiedTeams) {
      teams.add({
        "teamId": team['teamId'],
        'name': team['name'],
        'imagePath': team['imagePath'],
        "country": team['country']
      });
    }

    teams = shuffleTeams(teams);
    Map matchesRandom = await divisionOfMatchesRandom(teams);
    await addGroupsInFireStore(
        org: org,
        key: "matches",
        data: matchesRandom["matches"],
        nameRound: '$numRound');

    regRound(
        org: org, numRound: "4", name: "الدور النصف نهائي", type: 'normal');
  }

  @override
  Future doRound({required int numRound, required String org}) async {
    Map matches = await getRound(numRound: "${numRound * 2}", org: org);
    List<Map> teams = await qualifiedTeams(matches);
    teams = shuffleTeams(teams);
    Map matchesRandom = await divisionOfMatchesRandom(teams);

    await addGroupsInFireStore(
        key: "matches",
        org: org,
        data: matchesRandom["matches"],
        nameRound: '$numRound');
    if (numRound == 2) {
      regRound(
          org: org,
          numRound: "$numRound",
          name: "الدور النهائي",
          type: 'normal');
    } else {
      regRound(
          org: org,
          numRound: '$numRound',
          name: "الدور الاقصائي",
          type: 'normal');
    }
  }

  @override
  Future doRound8({required String org}) async {
    Map matches = await getRound(numRound: "16", org: org);
    List<Map> teams8 = await qualifiedTeams(matches);
    individuallyDivisionMatches(teams8);
    await addGroupsInFireStore(
      key: "matches",
      org: org,
      data: teams8,
      nameRound: '8',
    );
    regRound(org: org, numRound: "8", name: "الدور ثمن نهائي", type: '8round');
  }

  regRound(
      {required String org,
      required String numRound,
      required String type,
      required String name}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("vip_league")
        .doc("leagues")
        .set(
      {
        "leagues": FieldValue.arrayUnion([
          {"numRound": numRound, "name": name, "type": type}
        ]),
      },
      SetOptions(merge: true),
    );
  }

  getCurrentGameWeek() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("infoApp")
        .doc("gameWeek")
        .get();
    int numGameWeek = documentSnapshot['gameWeek'];
    return numGameWeek;
  }

  merge4Groups({
    required Map group1,
    required Map group2,
    required Map group3,
    required Map group4,
  }) {
    Map mergeGroups = {};
    mergeGroups.addAll(group1);
    mergeGroups.addAll(group2);
    mergeGroups.addAll(group3);
    mergeGroups.addAll(group4);
    return mergeGroups;
  }

  fourGroups(Map group) {
    Map firstGroups = {};
    Map secondGroups = {};
    Map thereGroups = {};
    Map fourthGroups = {};

    for (int i = 1; i <= group.length; i++) {
      if (i <= group.length / 4) {
        firstGroups['group$i'] = group['group$i'];
      } else if (i <= group.length / 2) {
        secondGroups['group$i'] = group['group$i'];
      } else if (i <= group.length * 3 / 4) {
        thereGroups['group$i'] = group['group$i'];
      } else {
        fourthGroups['group$i'] = group['group$i'];
      }
    }
    return {
      '1': firstGroups,
      '2': secondGroups,
      '3': thereGroups,
      '4': fourthGroups
    };
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
          "teamA": teams[i]['teamId'],
          "teamB": teams[j]['teamId'],
          "nameA": teams[i]['name'],
          "countryA": teams[i]['country'],
          "countryB": teams[j]['country'],
          "nameB": teams[j]['name'],
          "image2": teams[j]['imagePath'],
          "teamGoalsA": 0,
          "teamGoalsB": 0,
          "minusPoints": 0,
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
        'nameA': teams[i]['name'],
        'nameB': teams[numMatches + i]['name'],
        'imageTeamA': teams[i]['imagePath'],
        'imageTeamB': teams[numMatches + i]['imagePath'],
        'countryA': teams[i]['country'],
        'countryB': teams[numMatches + i]['country'],
        'gameWeekA': [],
        'gameWeekB': [],
        'teamA': teams[i]['teamId'],
        'teamB': teams[numMatches + i]['teamId'],
        'teamGoalsA': 0,
        'teamGoalsB': 0,
      });
    }
    return matches;
  }

  qualifiedTeams(
    Map matches,
  ) async {
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
              "minusPointsForAllGameWeek": 0,
            },
          );
        } else {
          qualifiedTeams.add({
            "teamId": match['teamB'],
            'name': match['nameB'],
            'imagePath': match['imageTeamB'],
            'country': match['countryB'],
            "minusPointsForAllGameWeek": 0,
          });
        }
      }));
    });

    await Future.wait(futures);

    return qualifiedTeams;
  }

  @override
  finishGameWeekInRound(
      {required int numRound,
      required String org,
      bool isBestOf3 = false,
      required int numGameWeek}) async {
    Map matches = await getRound(numRound: "$numRound", org: org);

    if (isBestOf3) {
      matches = await bestOf3(
          matches: matches, numGameWeek: numGameWeek, nameOrg: org);
    } else {
      matches = await roundTrip(
          matches: matches, numGameWeek: numGameWeek, nameOrg: org);
    }

    await addGroupsInFireStore(
        org: org,
        data: matches['matches'],
        nameRound: "$numRound",
        key: "matches");
  }

  roundTrip(
      {required Map matches,
      required String nameOrg,
      required numGameWeek}) async {
    List<Future> futures = [];

    matches['matches'].forEach((match) {
      futures.add(Future(() async {
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

        match['teamGoalsA'] = match['teamGoalsA'] - scoreALast;
        match['teamGoalsB'] = match['teamGoalsB'] - scoreBLast;

        Map teamA =
            await getPointsGameWeekTeam(match['teamA'], numGameWeek, nameOrg);
        Map teamB =
            await getPointsGameWeekTeam(match["teamB"], numGameWeek, nameOrg);

        int scoreA = teamA['score'];
        int scoreB = teamB['score'];
        match['teamGoalsA'] += scoreA;
        match['teamGoalsB'] += scoreB;

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
      }));
    });
    await Future.wait(futures);

    return matches;
  }

  bestOf3(
      {required Map matches,
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

  getVipLeagueTeams(
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

  groupDivision({
    required List<Map> othersTeams,
    required List<Map> teamsHead,
    required int countHead,
  }) async {
    Map groups = createGroups(countHead);
    groups = addHeadTeamsInGroups(groups, teamsHead);

    int numberOfGroups = 1;
    for (var i = 0; i < othersTeams.length; i++) {
      if (groups["group$numberOfGroups"].length == 16) {
        numberOfGroups++;
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "country": othersTeams[i]['country'],
          "minusPointsForAllGameWeek": 0,
          "matches": [],
        });
      } else {
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "country": othersTeams[i]['country'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "minusPointsForAllGameWeek": 0,
          "matches": [],
        });
      }
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
        "matches": [],
        "minusPointsForAllGameWeek": 0,
      });
    }
    return groups;
  }

  matchesDivisionCross(Map groups) {
    Map matches = {
      'matches': [],
    };

    for (int i = 1; i <= groups.length; i += 2) {
      for (int k = 0;
          k < groups['group${(groups.length + 1) - i}'].length;
          k++) {
        matches['matches'].add({
          "teamA": groups['group$i'][k]['teamId'],
          "teamB": groups['group${i + 1}'][7 - k]['teamId'],
          "countryA": groups['group$i'][k]['country'],
          "countryB": groups['group${i + 1}'][7 - k]['country'],
          "nameA": groups['group$i'][k]['name'],
          "nameB": groups['group${i + 1}'][7 - k]['name'],
          'imageTeamA': groups['group$i'][k]['imagePath'],
          'imageTeamB': groups['group${i + 1}'][7 - k]['imagePath'],
          'gameWeekA': [],
          'gameWeekB': [],
          "teamGoalsA": 0,
          "teamGoalsB": 0,
        });
      }
    }
    return matches;
  }

  matchesDivision(Map groups) {
    groups.forEach((key, value) {
      int totalTeams = value.length;
      int matchesPerRound = totalTeams ~/ 2;

      Map<String, dynamic> matchSchedule = {};

      for (int round = 0; round < 15; round++) {
        List<Map> roundSchedule = [];

        for (int match = 0; match < matchesPerRound; match++) {
          int home = (round + match) % (totalTeams - 1);
          int away = (totalTeams - 1 - match + round) % (totalTeams - 1);

          if (match == 0) {
            away = totalTeams - 1;
          }

          Map matchInfo = {
            "teamA": value[home]['teamId'],
            "teamB": value[away]['teamId'],
            "nameA": value[home]['name'],
            "nameB": value[away]['name'],
            "image2": value[away]['imagePath'],
            "countryA": value[home]['country'],
            "countryB": value[away]['country'],
          };

          roundSchedule.add(matchInfo);
        }

        matchSchedule['Round ${round + 1}'] = roundSchedule;
        for (int i = 0; i < value.length; i++) {
          List<Map> matchesTeam = [];
          matchSchedule.forEach((key, round) {
            round.forEach((element) {
              if (element['teamA'] == value[i]["teamId"]
                 ) {
                matchesTeam.add({
                  "teamA": value[i]['teamId'],
                  "teamB": element['teamB'],
                  "nameA": value[i]['name'],
                  "minusPoints": 0,
                  "nameB": element['nameB'],
                  "image2": element['image2'],
                  "countryA": value[i]['country'],
                  "countryB": element['countryB'],
                  "teamGoalsA": 0,
                  "teamGoalsB": 0,
                  "teamScoreA": 0,
                  "teamScoreB": 0,
                  "typeA": "",
                  "typeB": "",
                });
              } else if( element['teamB'] == value[i]["teamId"]){
                matchesTeam.add({
                  "teamA": value[i]['teamId'],
                  "teamB": element['teamA'],
                  "nameA": value[i]['name'],
                  "minusPoints": 0,
                  "nameB": element['nameA'],
                  "image2": element['image2'],
                  "countryA": value[i]['country'],
                  "countryB": element['countryA'],
                  "teamGoalsA": 0,
                  "teamGoalsB": 0,
                  "teamScoreA": 0,
                  "teamScoreB": 0,
                  "typeA": "",
                  "typeB": "",
                });

              }
            });
            value[i]["matches"] = matchesTeam;
          });
        }
      }
    });

    return groups;
  }

  selectQualifiedTeams(
    Map scoreGroups,
  ) {
    Map sortedGroups = {};

    scoreGroups.forEach((key, value) {
      value.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
      if (value[7]['points'] == value[8]['points']) {
        int i = 9;
        while (value[7]['points'] == value[i]['points']) {
          i++;
        }
        value = value.take(i + 1).toList();
        value.sort((a, b) => (b['minusPointsForAllGameWeek'] as int)
            .compareTo(a['minusPointsForAllGameWeek'] as int));

        var qualifiedTeams = value.take(8).toList();

        sortedGroups[key] = qualifiedTeams;
      } else {
        sortedGroups[key] = shuffleTeams(value.take(8).toList());
      }
    });

    return sortedGroups;
  }

  sortTeams(Map scoreGroups) {
    Map sortedGroups = {};
    scoreGroups.forEach((key, value) {
      value.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
      sortedGroups[key] = value;
    });
    return sortedGroups;
  }

  selectQualifiedTeamsInLastRound(
    Map scoreTeams,
  ) {
    List sortedTeams = scoreTeams['matches'];

    sortedTeams
        .sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
    List qualifiedTeams = sortedTeams.take(4).toList();

    return qualifiedTeams;
  }

  getRound({required String numRound, required String org}) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("vip_league")
        .doc(numRound);

    Map groups = (await documentReference.get()).data() as Map;

    return groups;
  }

  @override
  finishGameWeek(
      {required String orgName,
      required int numGameWeek,
      required String numRound}) async {
    Map newResult = await selectWinner(
      org: orgName,
      numGameWeek: numGameWeek,
      numRound: numRound,
    );

    newResult = sortTeams(newResult);
    var result = fourGroups(newResult);

    List<Future> futures = [
      addGroupsInFireStore(
          data: result["1"], nameRound: '$numRound-1', org: orgName),
      addGroupsInFireStore(
          data: result["2"], nameRound: '$numRound-2', org: orgName),
      addGroupsInFireStore(
          data: result["3"], nameRound: '$numRound-3', org: orgName),
      addGroupsInFireStore(
          data: result["4"], nameRound: '$numRound-4', org: orgName),
    ];
    await Future.wait(futures);
  }

  @override
  finishGameWeeKInLastRound(
      {required String org,
      required int numGameWeek,
      bool isVip128 = false}) async {
    int realNumGameWeek = numGameWeek;

    numGameWeek = (38 - numGameWeek) - (isVip128 ? 5 : 4);
    List newResult = await setResultGameWeekInLastRound(
        numGameWeek: numGameWeek, org: org, realNumGameWeek: realNumGameWeek);
    newResult = sortTeams({"matches": newResult})['matches'];

    await addGroupsInFireStore(
        org: org, key: 'matches', data: newResult, nameRound: '8');
  }

  setResultGameWeekInLastRound(
      {required int numGameWeek,
      required String org,
      required int realNumGameWeek}) async {
    Map dataRound = await getRound(numRound: "8", org: org);
    print("realNumGameWeek $realNumGameWeek");

    List teams = dataRound['matches'];

    numGameWeek = (numGameWeek - 8).abs();

    List<Future> futures = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams[i]['matches'].length; j++) {
        if (j == numGameWeek) {
          futures.add(Future(() async {
            /// delete last points
            if (teams[i]['matches'][numGameWeek]['teamGoalsA'] >
                    teams[i]['matches'][numGameWeek]['teamGoalsB'] ||
                teams[i]['matches'][numGameWeek]['teamGoalsA'] == 3) {
              teams[i]['points'] -=
                  teams[i]['matches'][numGameWeek]['teamGoalsA'];
            }

            print("numGameWeek $numGameWeek");

            teams[i]["minusPointsForAllGameWeek"] -=
                teams[i]['matches'][numGameWeek]['minusPoints'];

            Map teamA = await getPointsGameWeekTeam(
                teams[i]['matches'][j]['teamA'], realNumGameWeek, org);

            Map teamB = await getPointsGameWeekTeam(
                teams[i]['matches'][j]['teamB'], realNumGameWeek, org);

            int scoreHomeTeam = teamA['score'];
            int scoreAwayTeam = teamB['score'];

            // minus points
            teams[i]['matches'][numGameWeek]['minusPoints'] =
                (scoreHomeTeam - scoreAwayTeam);
            teams[i]["minusPointsForAllGameWeek"] +=
                teams[i]['matches'][numGameWeek]['minusPoints'];
            if (scoreHomeTeam > scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['teamGoalsA'] = 3;
              teams[i]['matches'][numGameWeek]['teamGoalsB'] = 0;
            } else if (scoreHomeTeam < scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['teamGoalsB'] = 3;
              teams[i]['matches'][numGameWeek]['teamGoalsA'] = 0;
            } else {
              teams[i]['matches'][numGameWeek]['teamGoalsA'] = 1;
              teams[i]['matches'][numGameWeek]['teamGoalsB'] = 1;
            }
            teams[i]['points'] +=
                teams[i]['matches'][numGameWeek]['teamGoalsA'];
          }));
        }
      }
    }
    await Future.wait(futures);
    return teams;
  }

  selectWinner(
      {required int numGameWeek,
      required String org,
      required String numRound}) async {
    List<Future> futuresGroups = [
      getRound(numRound: "$numRound-1", org: org),
      getRound(numRound: "$numRound-2", org: org),
      getRound(numRound: "$numRound-3", org: org),
      getRound(numRound: "$numRound-4", org: org),
    ];

    var rounds = await Future.wait(futuresGroups);

    Map mergeGroups = merge4Groups(
        group1: rounds[0]["groups"],
        group2: rounds[1]["groups"],
        group3: rounds[2]["groups"],
        group4: rounds[3]["groups"]);
    numGameWeek = numGameWeek - 1;

    List<Future> futures = [];

    mergeGroups.forEach((key, group) {
      for (int i = 0; i < group.length; i++) {
        for (int j = 0; j < group[i]['matches'].length; j++) {
          if (j == numGameWeek) {
            futures.add(Future(() async {
              /// delete last points
              if (group[i]['matches'][numGameWeek]['teamGoalsA'] >
                      group[i]['matches'][numGameWeek]['teamGoalsB'] ||
                  group[i]['matches'][numGameWeek]['teamGoalsA'] == 3) {
                group[i]['points'] -=
                    group[i]['matches'][numGameWeek]['teamGoalsA'];
              }

              /// delete last minus points
              group[i]["minusPointsForAllGameWeek"] -=
                  group[i]['matches'][numGameWeek]['minusPoints'];

              ///get score team a , team b
              Map teamA = await getPointsGameWeekTeam(
                  group[i]['matches'][j]['teamA'], numGameWeek + 1, org);
              Map teamB = await getPointsGameWeekTeam(
                  group[i]['matches'][j]['teamB'], numGameWeek + 1, org);

              int scoreA = teamA['score'];
              int scoreB = teamB['score'];
              String typeA = teamA['type'];
              String typeB = teamB['type'];

              // minus points
              group[i]['matches'][numGameWeek]['minusPoints'] =
                  (scoreA - scoreB);
              group[i]["minusPointsForAllGameWeek"] += (scoreA - scoreB);

              group[i]['matches'][numGameWeek]['teamScoreA'] = scoreA;
              group[i]['matches'][numGameWeek]['teamScoreB'] = scoreB;
              group[i]['matches'][numGameWeek]["typeA"] = typeA;
              group[i]['matches'][numGameWeek]["typeB"] = typeB;

              if (scoreA > scoreB) {
                group[i]['matches'][numGameWeek]['teamGoalsA'] = 3;
                group[i]['matches'][numGameWeek]['teamGoalsB'] = 0;

                group[i]['points'] +=
                    group[i]['matches'][numGameWeek]['teamGoalsA'];
              } else if (scoreA < scoreB) {
                group[i]['matches'][numGameWeek]['teamGoalsB'] = 3;
                group[i]['matches'][numGameWeek]['teamGoalsA'] = 0;
              } else {
                group[i]['matches'][numGameWeek]['teamGoalsA'] = 1;
                group[i]['matches'][numGameWeek]['teamGoalsB'] = 1;
                group[i]['points'] +=
                    group[i]['matches'][numGameWeek]['teamGoalsA'];
              }
            }));
          }
        }
      }
    });
    await Future.wait(futures);
    return mergeGroups;
  }

  addGroupsInFireStore(
      {required data,
      required String nameRound,
      String? key,
      required String org}) async {
    FirebaseFirestore.instance
        .collection("organizers")
        .doc(org)
        .collection("vip_league")
        .doc(nameRound)
        .set({
      key ?? "groups": data,
    });
  }

  Future<Map> getPointsGameWeekTeam(
      String teamId, int numGameWeek, String nameOrg) async {
    ///teams/00PtfoO0Sq5wmqvIxN9u/ organizers /Crazy fantasy
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection("organizers")
        .doc(nameOrg)
        .get();

    int points =
        documentSnapshot["VIP"]['gameWeek']["gameWeek$numGameWeek"]["score"];
    String type =
        documentSnapshot["VIP"]['gameWeek']["gameWeek$numGameWeek"]["type"];
    return {
      "score": points,
      "type": type,
    };
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

  Map createGroups(int countTeam) {
    Map groups = {};
    for (var i = 1; i <= countTeam; i++) {
      groups["group$i"] = [];
    }
    return groups;
  }

  List<T> shuffleTeams<T>(List<T> teams) {
    Random random = Random();

    for (int i = teams.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      T temp = teams[i];
      teams[i] = teams[j];
      teams[j] = temp;
    }

    return teams;
  }
}
