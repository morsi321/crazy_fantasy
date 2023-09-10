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
      await doSecondRound(org: org.id!, numRound: org.countTeams!);
    } else if (org.numGameWeek! == 16) {
      await finishGameWeekInRound(
          numRound: 256, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 17) {
      await finishGameWeekInRound(
          numRound: 256, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound(numRound: 128, org: org.id!);
    } else if (org.numGameWeek! == 18) {
      await finishGameWeekInRound(
          numRound: 128, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 19) {
      await finishGameWeekInRound(
          numRound: 128, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound(numRound: 64, org: org.id!);
    } else if (org.numGameWeek! == 20) {
      await finishGameWeekInRound(
          numRound: 64, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 21) {
      await finishGameWeekInRound(
          numRound: 64, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound(numRound: 32, org: org.id!);
    } else if (org.numGameWeek! == 22) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 23) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound(numRound: 16, org: org.id!);
    } else if (org.numGameWeek! == 24) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 25) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 34) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      await doRound(numRound: 2, org: org.id!);
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
      await doSecondRound(org: org.id!, numRound: org.countTeams!);
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
      await doRound(numRound: 64, org: org.id!);
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
      await doRound(numRound: 32, org: org.id!);
    } else if (org.numGameWeek! == 22) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 23) {
      await finishGameWeekInRound(
          numRound: 32, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound(numRound: 16, org: org.id!);
    } else if (org.numGameWeek! == 24) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 25) {
      await finishGameWeekInRound(
          numRound: 16, org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 26 && org.numGameWeek! <= 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 34) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      await doRound(numRound: 2, org: org.id!);
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
      await doSecondRound(org: org.id!, numRound: org.countTeams!);
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
      await doRound(numRound: 32, org: org.id!);
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
      await doRound(numRound: 16, org: org.id!);
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
      await doRound8(org: org.id!);
    } else if (org.numGameWeek! >= 25 && org.numGameWeek! <= 30) {
      await finishGameWeeKInLastRound(
          isVip128: true, org: org.id!, numGameWeek: org.numGameWeek!);
    } else if (org.numGameWeek! == 31) {
      await finishGameWeeKInLastRound(
          org: org.id!, numGameWeek: org.numGameWeek!);
      await doRound4(numRound: 4, org: org.id!);
    } else if (org.numGameWeek! == 32) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
    } else if (org.numGameWeek! == 33) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 4);
      await doRound(numRound: 2, org: org.id!);
    } else if (org.numGameWeek! == 34 || org.numGameWeek! == 35) {
      await finishGameWeekInRound(
          org: org.id!, numGameWeek: org.numGameWeek!, numRound: 2);
    }
  }

  @override
  Future createVip({required Organizer org}) async {
    String numRound1 = '';
    String numRound2 = '';
    int countHead = 0;
    if (org.countTeams == "512") {
      numRound1 = '512-1';
      numRound2 = '512-2';
      countHead = 32;
    } else if (org.countTeams == "256") {
      numRound1 = '256-1';
      numRound2 = '256-2';
      countHead = 16;
    } else if (org.countTeams == "128") {
      numRound1 = '128-1';
      numRound2 = '128-2';
      countHead = 8;
    }

    (List<Map>, List<Map>) teams =
        await getVipLeagueTeams(teamsId: org.otherChampionshipsTeams!);
    List<Map> headTeam = teams.$1;
    List<Map> othersTeam = teams.$2;
    Map groupWithMatches = await groupDivision(
        othersTeams: othersTeam, teamsHead: headTeam, countHead: countHead);
    Map<dynamic, dynamic> matches = matchesDivision(groupWithMatches);
    var groups = halfGroups(matches);
    Map half1Group = groups.$1;
    Map half2Group = groups.$2;
    List<Future> futures = [
      addGroupsInFireStore(
          data: half1Group, nameRound: numRound1, org: org.id!),
      addGroupsInFireStore(data: half2Group, nameRound: numRound2, org: org.id!)
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
    Map half1 = await getRound(numRound: "$numRound-1", org: org);
    Map half2 = await getRound(numRound: "$numRound-2", org: org);

    Map mergeGroups = merge2Groups(half1["groups"], half2["groups"]);

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
        "country":team['country']
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

  merge2Groups(Map group1, Map group2) {
    Map mergeGroups = {};
    for (int i = 1; i <= group1.length * 2; i++) {
      if (i <= group1.length) {
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
          "teamA": teams[i]['teamId'],
          "teamB": teams[j]['teamId'],
          "nameA": teams[i]['name'],
          "countryA":teams[i]['country'],
          "countryB":teams[j]['country'],
          "gameWeekA": [],
          "gameWeekB": [],
          "nameB": teams[j]['name'],
          "image2": teams[j]['imagePath'],
          // "image1": teams[i]['imagePath'],
          "teamGoalsA": 0,
          "teamGoalsB": 0,
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
        'countryA':teams[i]['country'],
        'countryB':teams[numMatches + i]['country'],
        'gameWeekA': [],
        'gameWeekB': [],
        'teamA': teams[i]['teamId'],
        'teamB': teams[numMatches + i]['teamId'],
        'teamAGoals': 0,
        'teamBGoals': 0,
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
        int score1 = match["teamAGoals"];
        int score2 = match["teamBGoals"];
        if (score1 > score2) {
          qualifiedTeams.add(
            {
              "teamId": match['teamA'],
              'name': match['nameA'],
              'imagePath': match['imageTeamA'],
              'country':match['countryA']
            },
          );
        } else {
          qualifiedTeams.add({
            "teamId": match['teamB'],
            'name': match['nameB'],
            'imagePath': match['imageTeamB'],
            'country':match['countryB']

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
   matches=   await roundTrip(matches: matches, numGameWeek: numGameWeek, nameOrg: org);
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
        Map teamA =
            await getPointsGameWeekTeam(match['teamA'], numGameWeek, nameOrg);
        Map teamB =
            await getPointsGameWeekTeam(match["teamB"], numGameWeek, nameOrg);
        int scoreA = teamA['score'];
        int scoreB = teamB['score'];
        match['teamAGoals'] += scoreA;
        match['teamBGoals'] += scoreB;
        match['gameWeekA'].add({
          "numGameWeek": numGameWeek,
          "score": scoreA,
          "type": teamA['type'],
        });
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
        Map teamA =
            await getPointsGameWeekTeam(match['teamA'], numGameWeek, nameOrg);
        Map teamB =
            await getPointsGameWeekTeam(match["teamB"], numGameWeek, nameOrg);
        int scoreA = teamA['score'];
        int scoreB = teamB['score'];

        match['gameWeekA'].add({
          "numGameWeek": numGameWeek,
          "score": scoreA,
          "type": teamA['type'],
        });
        match['gameWeekB'].add({
          "numGameWeek": numGameWeek,
          "score": scoreB,
          "type": teamB['type'],
        });

        if (scoreA > scoreB) {
          match['teamAGoals'] = match['teamAGoals'] + 1;
        } else if (scoreA < scoreB) {
          match['teamBGoals'] = match['teamBGoals'] + 1;
        }

      }));
    });
    await Future.wait(futures);

    return matches;
  }

  getVipLeagueTeams({required List<Map> teamsId}) async {
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
    groups = addHeadTeamsInGroups(groups, teamsHead, countHead);
    int numberOfGroups = 1;
    for (var i = 0; i < othersTeams.length; i++) {
      if (groups["group$numberOfGroups"].length == 16) {
        numberOfGroups++;
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "country" : othersTeams[i]['country'],
          "matches": [],
        });
      } else {
        groups["group$numberOfGroups"].add({
          "teamId": othersTeams[i]['id'],
          "country" : othersTeams[i]['country'],
          "name": othersTeams[i]['name'],
          "imagePath": othersTeams[i]['path'].split('/').last,
          "points": 0,
          "matches": [],
        });
      }
    }

    return groups;
  }

  addHeadTeamsInGroups(
    Map groups,
    List<Map> teamsHead,
    int countHead,
  ) {
    if (teamsHead.length > countHead) {
      teamsHead = teamsHead.take(countHead).toList();
    }

    for (int i = 0; i < teamsHead.length; i++) {
      groups['group${i + 1}'].add({
        "teamId": teamsHead[i]['id'],
        "name": teamsHead[i]['name'],
        "imagePath": teamsHead[i]['path'].split('/').last,
        "points": 0,
        "country" : teamsHead[i]['country'],
        "matches": [],
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
          "teamAGoals": 0,
          "teamBGoals": 0,
        });
      }
    }
    return matches;
  }

  matchesDivision(Map teams) {
    List<Map> matches = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams["group${i + 1}"].length; j++) {
        for (int k = 0; k < teams["group${i + 1}"].length; k++) {
          if (j == k) {
            continue;
          }
          matches.add({
            "teamA": teams["group${i + 1}"][j]['teamId'],
            "teamB": teams["group${i + 1}"][k]['teamId'],
            "nameA": teams["group${i + 1}"][j]['name'],
            "nameB": teams["group${i + 1}"][k]['name'],
            "image2": teams["group${i + 1}"][k]['imagePath'],
            "countryA": teams["group${i + 1}"][j]['country'],
            "countryB": teams["group${i + 1}"][k]['country'],

            "teamGoalsA": 0,
            "teamGoalsB": 0,
          });
        }
        teams["group${i + 1}"][j]['matches'] = matches;
        matches = [];
      }
    }

    return teams;
  }

  selectQualifiedTeams(
    Map scoreGroups,
  ) {
    Map sortedGroups = {};

    scoreGroups.forEach((key, value) {
      value.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
      sortedGroups[key] = shuffleTeams(value.take(8).toList());
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
    var result = halfGroups(newResult);

    Map half1Group = result.$1;
    Map half2Group = result.$2;
    half1Group =sortTeams(half1Group);
    half2Group =sortTeams(half2Group);

    await addGroupsInFireStore(
        data: half1Group, nameRound: '$numRound-1', org: orgName);

    await addGroupsInFireStore(
        data: half2Group, nameRound: '$numRound-2', org: orgName);
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
    newResult =sortTeams({"matches":newResult})['matches'];

    await addGroupsInFireStore(
        org: org, key: 'matches', data: newResult, nameRound: '8');
  }

  setResultGameWeekInLastRound(
      {required int numGameWeek,
      required String org,
      required int realNumGameWeek}) async {
    Map dataRound = await getRound(numRound: "8", org: org);

    List teams = dataRound['matches'];

    numGameWeek = (numGameWeek - 8).abs();

    List<Future> futures = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams[i]['matches'].length; j++) {
        if (j == numGameWeek) {
          futures.add(Future(() async {
            Map teamA = await getPointsGameWeekTeam(
                teams[i]['matches'][j]['teamA'], numGameWeek + 1, org);
            Map teamB = await getPointsGameWeekTeam(
                teams[i]['matches'][j]['teamB'], numGameWeek + 1, org);
            int scoreHomeTeam = teamA['score'];
            int scoreAwayTeam = teamB['score'];

            // teams[i]['matches'][numGameWeek]['gameWeekHome'].add({
            //   "$realNumGameWeek": scoreHomeTeam,
            // });
            // teams[i]['matches'][numGameWeek]['gameWeekAway'].add({
            //   "$realNumGameWeek": scoreAwayTeam,
            // });

            if (scoreHomeTeam > scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['teamGoalsA'] = 3;
            } else if (scoreHomeTeam < scoreAwayTeam) {
              teams[i]['matches'][numGameWeek]['teamGoalsB'] = 3;
            } else {
              teams[i]['matches'][numGameWeek]['teamGoalsA'] = 1;
              teams[i]['matches'][numGameWeek]['teamGoalsB'] = 1;
            }
            teams[i]['points'] +=
                teams[i]['matches'][numGameWeek]['teamGoalsA'];
          }));
          // group[i]['points'] += totalPoints;
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
    Map half1 = await getRound(numRound: "$numRound-1", org: org);
    Map half2 = await getRound(numRound: "$numRound-2", org: org);
    Map merge2Group = merge2Groups(half1['groups'], half2['groups']);
    numGameWeek = numGameWeek - 1;

    List<Future> futures = [];

    merge2Group.forEach((key, group) {
      for (int i = 0; i < group.length; i++) {
        for (int j = 0; j < group[i]['matches'].length; j++) {
          if (j == numGameWeek) {
            futures.add(Future(() async {
              Map teamA= await getPointsGameWeekTeam(
                  group[i]['matches'][j]['teamA'], numGameWeek + 1, org);
              Map teamB = await getPointsGameWeekTeam(
                  group[i]['matches'][j]['teamB'], numGameWeek + 1, org);
              int scoreA = teamA['score'];
              int scoreB = teamB['score'];

              if (scoreA > scoreB) {
                group[i]['matches'][numGameWeek]['teamGoalsA'] = 3;

                group[i]['points'] +=
                    group[i]['matches'][numGameWeek]['teamGoalsA'];
              } else if (scoreA < scoreB) {
                group[i]['matches'][numGameWeek]['teamGoalsB'] = 3;
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
    return merge2Group;
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

 Future<Map> getPointsGameWeekTeam(String teamId, int numGameWeek, String nameOrg) async {
    ///teams/00PtfoO0Sq5wmqvIxN9u/organizers/Crazy fantasy
    ///
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection("organizers")
        .doc(nameOrg)
        .get();

    int points =
        documentSnapshot["vip"]['gameWeek']["gameWeek$numGameWeek"]["score"];
    String type = documentSnapshot["vip"]['gameWeek']["gameWeek$numGameWeek"]
        ["type"];
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
