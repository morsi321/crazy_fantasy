import '../../../../../core/models/team.dart';

abstract class OrganizerRepo {
  Future addOrganizersInTeamsForChamp1000Team(
      {required List<Team> teams, required String nameOrg});

  Future addOrganizersInTeamsForOthersChampions(
      { required List<Team> teams,
      required String nameOrg,
      required List<String> championShip});
  Future removeOrgOthersChampions(
      {required List<String> teams, required String nameOrg});

  Future removeOrgChampion1000Team(
      {required List<String> teams,
      required String nameOrg,});


}
