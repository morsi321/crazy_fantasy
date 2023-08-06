import 'OrganizersRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizersRepoImpl implements OrganizerRepo {
  @override
  Future addOrganizersInTeams() async {
    List teams = await getAllTeams();
    print(teams.length );
    List organizers = await getNameAllOrganizers();
    List<Future> futures = [];
    for (var team in teams) {
      String idTeam = team.reference.id;
      for (var org in organizers) {
        futures.add(FirebaseFirestore.instance
            .collection('teams')
            .doc(idTeam)
            .collection('organizers')
            .doc(org)
            .set({
            'classic': {
              "gameWeek":{},
              "totalPoints": 0,
              "chosen": "captain",
              "tripleCaptain": true,
              "maxCaptain": true,
              "freeMinus": true,
              "guestPlayer": true,
            },
            'vip': {
              "gameWeek":{},
              "totalPoints": 0,
              "chosen": "captain",
              "tripleCaptain": true,
              "maxCaptain": true,
              "freeMinus": true,
              "guestPlayer": true,
            },
            'cup': {
              "gameWeek":{},
              "totalPoints": 0,
              "chosen": "captain",
              "tripleCaptain": true,
              "maxCaptain": true,
              "freeMinus": true,
              "guestPlayer": true,
            },
            'team1000': {
              "gameWeek":{},
              "totalPoints": 0,
              "chosen": "captain",
              "tripleCaptain": true,
              "maxCaptain": true,
              "freeMinus": true,
              "guestPlayer": true,
            },
          }
        ));
      }
    }

    await Future.wait(futures);
  }

  getAllTeams() async {
    QuerySnapshot teams =
        await FirebaseFirestore.instance.collection('teams').get();
    return teams.docs;
  }

  getNameAllOrganizers() async {
    List<String> listOrganizers = ["Crazy Fantasy"];

    QuerySnapshot organizers =
        await FirebaseFirestore.instance.collection('organizers').get();
    for (var org in organizers.docs) {
      String name = org['name'];
      listOrganizers.add(name);
    }
    return listOrganizers;
  }
}
