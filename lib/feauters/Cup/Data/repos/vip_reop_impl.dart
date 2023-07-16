import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'vip_reop.dart';

class OrganizeCupChampionshipRepoImpl implements OrganizeCupChampionshipRepo {
  @override
  Future<Either<String, String>> createCup() async {
    try {
      List<Map> teams = await getCupLeagueTeams();

      teams = shuffleTeams(teams);
      Map matches = divisionOfMatches(teams);
      await updateNumGameWeek(firstGameWeek: true);

      await addGroupsInFireStore(matches: matches, nameRound: 'الدور 512');

      return right("تم انشاء بطولة VIP بنجاح");
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  @override
  Future<Either<String, String>> doRound({required int numRound}) async {
    try {
      Map matches =
          await getMatchesLastRound(nameRound: 'الدور ${numRound * 2}');

      List<Map> teams = await qualifiedTeams(matches);
      teams = shuffleTeams(teams);
      Map newMatches = divisionOfMatches(teams);
      await updateNumGameWeek();
      await addGroupsInFireStore(
          matches: newMatches, nameRound: 'الدور $numRound');

      return right("تم تنظيم الدور $numRound بنجاح");
    } catch (e) {
      print(e.toString());
      return left("حدث خطأ ما يرجى المحاولة مرة أخرى");
    }
  }

  finishGameWeek({required int numRound}) async {
    try {
      Map matches = await getMatchesLastRound(nameRound: 'الدور $numRound');
      await chooseWinnerTheGameWeek(matches, 1);
      await updateNumGameWeek();
      await addGroupsInFireStore(
          matches: matches, nameRound: 'الدور $numRound');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  removeGameWeek({required int numRound} ) async {
    try {
      Map matches = await getMatchesLastRound(nameRound: 'الدور $numRound');
      await chooseWinnerTheGameWeek(matches, -1);
      await updateNumGameWeek(deleteGameWeek: true);
      await addGroupsInFireStore(matches: matches, nameRound: 'الدور $numRound');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getCupLeagueTeams() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('isCupLeague', isEqualTo: true)
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

  divisionOfMatches(List<Map> teams) {
    Map matches = {
      'matches': [],
    };
    int numMatches = teams.length ~/ 2;
    for (int i = 0; i < numMatches; i++) {
      matches['matches'].add({
        'nameTeam1': teams[i]['name'],
        'nameTeam2': teams[numMatches + i]['name'],
        'imagePath1': teams[i]['imagePath'],
        'imagePath2': teams[numMatches + i]['imagePath'],
        'teamId1': teams[i]['id'],
        'teamId2': teams[numMatches + i]['id'],
        'score1': 0,
        'score2': 0,
      });
    }
    return matches;
  }

  chooseWinnerTheGameWeek(Map matches, int increment) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future> futures = [];

      matches['matches'].forEach((match) async {
        futures.add(Future(() async {
          int score1 = await getTotalPointsTeam(match['teamId1']);
          int score2 = await getTotalPointsTeam(match["teamId2"]);

          if (score1 > score2) {
            match['score1'] = match['score1'] + increment;
            match['score2'] = 0;
          } else if (score1 < score2) {
            match['score1'] = 0;
            match['score2'] = match['score2'] + increment;
          }else{
            match['score1'] = match['score1'];
            match['score2'] = match['score2'];
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

  qualifiedTeams(
    Map matches,
  ) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      List<Future> futures = [];

      List<Map> qualifiedTeams = [];

      matches['matches'].forEach((match) async {
        futures.add(Future(() async {
          int score1 = match["score1"];
          int score2 = match["score2"];

          if (score1 > score2) {
            qualifiedTeams.add(
              {
                "id": match['teamId1'],
                'name': match['nameTeam1'],
                'imagePath': match['imagePath1']
              },
            );
          } else if (score1 < score2) {
            qualifiedTeams.add({
              "id": match['teamId2'],
              'name': match['nameTeam2'],
              'imagePath': match['imagePath2']
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

  addGroupsInFireStore(
      {required Map matches, required String nameRound}) async {
    try {
      FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("Vip")
          .collection("vip")
          .doc(nameRound)
          .set({
        "isFinished": false,
        "matches": matches['matches'],
      });
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
      print(documentSnapshot['totalScore']);
      return documentSnapshot['totalScore'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  updateNumGameWeek(
      {bool deleteGameWeek = false, bool firstGameWeek = false}) async {
    try {
      DocumentReference fire =  FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("Vip");

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

  getMatchesLastRound({required String nameRound}) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("Crazy_fantasy")
          .doc("Vip")
          .collection("vip")
          .doc(nameRound);
      Map matches = (await documentReference.get()).data() as Map;
      return matches;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
