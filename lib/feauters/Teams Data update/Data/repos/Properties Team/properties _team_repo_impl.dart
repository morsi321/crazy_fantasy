import 'Properties_team_repo.dart';

class PropertiesTeamRepoImpl implements PropertiesTeamRepo {
  @override
  int doubleScore({required List scores}) {
    int scoreCaptain =
        scores.firstWhere((element) => element["type"] == "captain")["score"];
    scoreCaptain = scoreCaptain * 2;
    int otherScore = scores
        .where((element) =>
            element["type"] != "captain" &&
            element["id"] != "" &&
            element["name"] != "guestPlayer" &&
            element["name"] != "disablePlayer")
        .map((e) => e["score"])
        .reduce((value, element) => value + element);
    return scoreCaptain + otherScore;
  }

  @override
  int freeScore({required List scores}) {
    throw UnimplementedError();
  }

  @override
  int maximumScore({required List scores}) {
    int maxIndexScore = 0;
    print(scores);
    for (int i = 0; i < 5; i++) {
      if (scores[i]["score"] > scores[maxIndexScore]["score"]) {
        maxIndexScore = i;
      }
    }
    int maxScore = scores[maxIndexScore]["score"] * 2;
    scores.removeAt(maxIndexScore);
    int sum = scores[0]["score"] +
        scores[1]["score"] +
        scores[2]["score"] +
        scores[3]["score"] +
        maxScore;
    return sum;
  }

  @override
  int tripleScore({required List scores}) {
    int scoreCaptain =
    scores.firstWhere((element) => element["type"] == "captain")["score"];
    scoreCaptain = scoreCaptain * 3;
    int otherScore = scores
        .where((element) =>
    element["type"] != "captain" &&
        element["id"] != "" &&
        element["name"] != "guestPlayer" &&
        element["name"] != "disablePlayer")
        .map((e) => e["score"])
        .reduce((value, element) => value + element);
    return scoreCaptain + otherScore;
  }
}
