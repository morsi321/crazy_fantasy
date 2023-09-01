import 'OrganizersRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizersRepoImpl implements OrganizerRepo {
  @override
  Future addOrganizersInTeamsForOthersChampions(
      {required List<String> teams,
      required String nameOrg,
      required List<String> championShip}) async {
    Map<String, dynamic> champions = handelChampion(champions: championShip);
    addOrgInTeams(teams: teams, nameOrg: nameOrg, champions: champions);
  }

  Map<String, dynamic> handelChampion({required List<String> champions}) {
    Map<String, dynamic> champs = {};
    for (String champ in champions) {
      champs[champ] = {
        "gameWeek": {},
        "totalPoints": 0,
        "chosen": "captain",
        "tripleCaptain": true,
        "maxCaptain": true,
        "freeMinus": true,
        "guestPlayer": true,
      };
    }
    return champs;
  }

  addOrgInTeams(
      {required List<String> teams,
      required String nameOrg,
      required Map<String, dynamic> champions}) async {
    List<Future> futures = [];
    for (var team in teams) {
      futures.add(addOneTeamInOrg(
          teamId: team, nameOrg: nameOrg, champions: champions));
    }

    await Future.wait(futures);
  }

  getAllTeams() async {
    QuerySnapshot teams =
        await FirebaseFirestore.instance.collection('teams').get();
    return teams.docs;
  }



  @override
  Future addOrganizersInTeamsForChamp1000Team(
      {required List<String> teams, required String nameOrg}) async {
    for (String team in teams) {
      Map<String, dynamic> champions =
          await getOrg(nameOrg: nameOrg, teamId: team) as Map<String, dynamic>;
      champions['team1000'] = {
        "gameWeek": {},
        "totalPoints": 0,
        "chosen": "captain",
        "tripleCaptain": true,
        "maxCaptain": true,
        "freeMinus": true,
        "guestPlayer": true,
      };

      await addOneTeamInOrg(
          teamId: team, nameOrg: nameOrg, champions: champions);
    }
  }

  Future<Map> getOrg({required String nameOrg, required String teamId}) async {
    Map<String, dynamic> orgChampions = {};
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection('organizers')
        .doc(nameOrg)
        .get();

    if (docs.exists) {
      orgChampions = docs.data() as Map<String, dynamic>;
    }
    return orgChampions;
  }

  addOneTeamInOrg(
      {required String teamId,
      required String nameOrg,
      required Map<String, dynamic> champions}) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection('organizers')
        .doc(nameOrg)
        .set(champions);
  }

  @override
  Future removeOrgChampion1000Team(
      {required List<String> teams, required String nameOrg}) async {
    List<Future> futures = [];

    for (String teamId in teams) {
      futures.add(Future(() async {
        Map<String, dynamic> champions =
            await getOrg(nameOrg: nameOrg, teamId: teamId)
                as Map<String, dynamic>;
        removeOrgFromOneTeamForChampion1000Team(
            champions: champions, nameOrg: nameOrg, id: teamId);
      }));
    }
    await Future.wait(futures);
  }

  @override
  Future removeOrgOthersChampions(
      {required List<String> teams, required String nameOrg}) async {

    List<Future> futures = [];
    for (String teamId in teams) {
      futures.add(Future(() async {
        Map<String, dynamic> champions =
            await getOrg(nameOrg: nameOrg, teamId: teamId)
                as Map<String, dynamic>;

        removeOrgFromOneTeamForOthersChampions(
            champions: champions, nameOrg: nameOrg, id: teamId);
      }));
    }
    await Future.wait(futures);
  }

  removeOrgFromOneTeamForChampion1000Team(
      {required Map<String, dynamic> champions,
      required String nameOrg,
      required String id}) async {
    if (champions.length > 1) {
      print("11111");
      champions.remove("team1000");
      addOneTeamInOrg(teamId: id, nameOrg: nameOrg, champions: champions);
    } else {
      await deleteOrg(teamId: id, nameOrg: nameOrg);
    }
  }

  removeOrgFromOneTeamForOthersChampions(
      {required Map<String, dynamic> champions,
      required String nameOrg,
      required String id}) async {
    if (champions.containsKey("team1000")) {
      Map<String, dynamic> newChampions = {"team1000": champions['team1000']};
      addOneTeamInOrg(teamId: id, nameOrg: nameOrg, champions: newChampions);
    } else {
      await deleteOrg(teamId: id, nameOrg: nameOrg);
    }
  }

  deleteOrg({required String teamId, required String nameOrg}) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .collection('organizers')
        .doc(nameOrg)
        .delete();
  }


}
