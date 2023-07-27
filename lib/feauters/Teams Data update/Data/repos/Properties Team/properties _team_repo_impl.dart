import 'Properties_team_repo.dart';

class PropertiesTeamRepoImpl implements PropertiesTeamRepo {
  @override
  int doubleScore({required List scores}) {
    return ((scores[0]* 2) + scores[1] + scores[2] + scores[3] + scores[4]);
  }

  @override
  int freeScore({required List scores}) {
    // TODO: implement freeScore
    throw UnimplementedError();
  }

  @override
  int maximumScore({required List scores}) {
    int maxIndexScore = 0;
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] > scores[maxIndexScore]) {
        maxIndexScore = i;
      }
    }
    int maxScore = scores[maxIndexScore] * 2;
    scores.removeAt(maxIndexScore);
    int sum = scores[0] + scores[1] + scores[2] + scores[3] + maxScore;
    return sum;
  }

  @override
  int tripleScore({required List scores}) {

    return ((scores[0] * 3) + scores[1] + scores[2] + scores[3] + scores[4]);

  }
}
