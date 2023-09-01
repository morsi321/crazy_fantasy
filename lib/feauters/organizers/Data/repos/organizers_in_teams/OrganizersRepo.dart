abstract class OrganizerRepo {
  Future addOrganizersInTeamsForChamp1000Team(
      {required List<String> teams, required String nameOrg});

  Future addOrganizersInTeamsForOthersChampions(
      {required List<String> teams,
      required String nameOrg,
      required List<String> championShip});
  Future removeOrgOthersChampions(
      {required List<String> teams, required String nameOrg});

  Future removeOrgChampion1000Team(
      {required List<String> teams,
      required String nameOrg,});


}
