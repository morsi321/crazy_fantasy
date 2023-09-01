class Team {
  String? id;
  String? name;
  String? country;
  String? pathImage;
  int? fantasyID1;
  int? fantasyID2;
  int? fantasyID3;
  bool? isHeading;

  int? fantasyID4;

  String? managerID;
  int? captain;

  Team({
    this.id,
    this.name,
    this.country,
    this.pathImage,
    this.fantasyID1,
    this.fantasyID2,
    this.fantasyID3,
    this.fantasyID4,
    this.managerID,
    this.captain,
    this.isHeading,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'captain': captain,
      if (pathImage != null) 'path': pathImage,
      'fantasyID1': fantasyID1,
      'fantasyID2': fantasyID2,
      'fantasyID3': fantasyID3,
      'fantasyID4': fantasyID4,
      'managerID': managerID,
    };
  }

  Team.fromJson(
    Map<String, dynamic> json,
    String idDoc,
  { bool? isHead}
  )   : id = idDoc,
        isHeading = isHead??false,
        name = json['name'],
        pathImage = json['path'],
        captain = json['captain'],
        fantasyID1 = json['fantasyID1'],
        fantasyID2 = json['fantasyID2'],
        fantasyID3 = json['fantasyID3'],
        fantasyID4 = json['fantasyID4'],
        managerID = json['managerID'],
        country = json['country'];
}
