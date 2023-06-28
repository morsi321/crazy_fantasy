class Team {
  String? id;
  String? name;
  String? pathImage;
  String? fantasyID1;
  String? fantasyID2;
  String? fantasyID3;
  String? fantasyID4;
  String? fantasyID5;
  String? managerID;
  String? captain;
  String? champion;

  Team({
    this.id,
    this.captain,
    this.name,
    this.champion,
    this.pathImage,
    this.fantasyID1,
    this.fantasyID2,
    this.fantasyID3,
    this.fantasyID4,
    this.fantasyID5,
    this.managerID,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': pathImage,
      'captain': captain,
      'fantasyID1': fantasyID1,
      'champion': champion,
      'fantasyID2': fantasyID2,
      'fantasyID3': fantasyID3,
      'fantasyID4': fantasyID4,
      'fantasyID5': fantasyID5,
      'managerID': managerID,
    };
  }

  Team.fromJson(Map<String, dynamic> json, String idDoc)
      :id = idDoc,
        name = json['name'],
        pathImage = json['path'],
        captain = json['captain'],
        fantasyID1 = json['fantasyID1'],
        fantasyID2 = json['fantasyID2'],
        fantasyID3 = json['fantasyID3'],
        fantasyID4 = json['fantasyID4'],
        fantasyID5 = json['fantasyID5'],
        managerID = json['managerID'],
        champion = json['champion'];
}
