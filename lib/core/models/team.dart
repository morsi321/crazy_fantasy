import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  String? id;
  String? name;
  String? country;
  String? pathImage;
  int? fantasyID1;
  int? scoreFantasyID1;
  int? fantasyID2;
  int? scoreFantasyID2;
  int? fantasyID3;
  int? scoreFantasyID3;

  int? fantasyID4;
  int? scoreFantasyID4;
  bool? isTeams1000;
  bool? isCup;

  bool? isClassicLeague;
  bool? isVipLeague;

  int? scoreCaptain;
  String? managerID;
  int? captain;
  int? totalScore;

  Team(
      {this.id,
      this.name,
      this.country,
      this.isTeams1000,
      this.isCup,
      this.isClassicLeague,
      this.isVipLeague,
      this.pathImage,
      this.fantasyID1,
      this.scoreFantasyID1,
      this.fantasyID2,
      this.scoreFantasyID2,
      this.fantasyID3,
      this.scoreFantasyID3,
      this.fantasyID4,
      this.scoreFantasyID4,
      this.scoreCaptain,
      this.managerID,
      this.captain,
      this.totalScore});

  Map<String, dynamic> toMap() {
    totalScore = calTotalScore();
    return {
      'name': name,
      'country': country,
      'captain': captain,
      'isTeams1000': isTeams1000,
      'isCup': isCup,
      'isClassicLeague': isClassicLeague,
      'isVipLeague': isVipLeague,
      'totalScore': totalScore,
      if (pathImage != null) 'path': pathImage,
      'fantasyID1': fantasyID1,
      'fantasyID2': fantasyID2,
      'fantasyID3': fantasyID3,
      'fantasyID4': fantasyID4,
      'managerID': managerID,
      'scoreFantasyID1': scoreFantasyID1,
      'scoreFantasyID2': scoreFantasyID2,
      'scoreFantasyID3': scoreFantasyID3,
      'scoreFantasyID4': scoreFantasyID4,
      'scoreCaptain': scoreCaptain,
    };
  }

  Team.fromJson(
    Map<String, dynamic> json,
    String idDoc,
  )   : id = idDoc,
        name = json['name'],
        pathImage = json['path'],
        captain = json['captain'],
        fantasyID1 = json['fantasyID1'],
        fantasyID2 = json['fantasyID2'],
        fantasyID3 = json['fantasyID3'],
        fantasyID4 = json['fantasyID4'],
        managerID = json['managerID'],
        country = json['country'],
        isTeams1000 = json['isTeams1000'],
        isCup = json['isCup'],
        isClassicLeague = json['isClassicLeague'],
        isVipLeague = json['isVipLeague'],
        scoreCaptain = json['scoreCaptain'],
        scoreFantasyID1 = json['scoreFantasyID1'],
        scoreFantasyID2 = json['scoreFantasyID2'],
        scoreFantasyID3 = json['scoreFantasyID3'],
        scoreFantasyID4 = json['scoreFantasyID4'] {
    calTotalScore();
  }

   calTotalScore() {
    totalScore = scoreFantasyID1! +
        scoreFantasyID2! +
        scoreFantasyID3! +
        scoreFantasyID4! +
        (scoreCaptain!) * 2;

    return totalScore;
  }
}
