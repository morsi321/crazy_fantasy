class Organizer {
  String? id;
  String? name;
  String? whatsApp;
  String? phone;
  String? image;
  String? description;
  String? urlFacebook;
  String? urlTwitter;
  String? urlInstagram;
  String? urlYoutube;
  String? urlTiktok;
  String? countTeams;
  bool? isCupLeague;
  bool? isVipLeague;
  bool? isClassicLeague;
  bool? isTeam1000League;
  int? numGameWeek;
  bool? isCloseUpdate;
  bool ?isUpdateRealTime;

  List<Map>? otherChampionshipsTeams;
  List<String>? teams1000Id;

  Organizer({
    this.name,
    this.numGameWeek,
    this.whatsApp,
    this.phone,
    this.image,
    this.description,
    this.urlFacebook,
    this.urlTwitter,
    this.urlInstagram,
    this.urlYoutube,
    this.urlTiktok,
    this.isCupLeague,
    this.isVipLeague,
    this.isClassicLeague,
    this.isTeam1000League,
    this.countTeams,
    this.otherChampionshipsTeams,
    this.teams1000Id,
    this.isCloseUpdate,
    this.isUpdateRealTime,
  });

  Organizer.fromJson(Map<String, dynamic> json, {required String idOrganizer}) {
    id = idOrganizer;
    name = json['name'];
    isCloseUpdate = json['isCloseUpdate'] ;
    numGameWeek = json['numGameWeek'];
    whatsApp = json['whatsApp'];
    phone = json['phone'];
    image = json['image'];
    description = json['description'];
    urlFacebook = json['urlFacebook'];
    urlTwitter = json['urlTwitter'];
    urlInstagram = json['urlInstagram'];
    urlYoutube = json['urlYoutube'];
    urlTiktok = json['urlTiktok'];
    countTeams = json['countTeam'];
    isCupLeague = json['isCupLeague'];
    isVipLeague = json['isVipLeague'];
    isClassicLeague = json['isClassicLeague'];
    isTeam1000League = json['isTeam1000League'];
    otherChampionshipsTeams = json['otherChampionshipsTeams'].cast<Map>();
    teams1000Id = json['teams1000Id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['numGameWeek'] = numGameWeek;
    data['isCloseUpdate'] = isCloseUpdate;
    data['whatsApp'] = whatsApp;
    data['phone'] = phone;
    data['image'] = image;
    data['description'] = description;
    data['urlFacebook'] = urlFacebook;
    data['urlTwitter'] = urlTwitter;
    data['urlInstagram'] = urlInstagram;
    data['urlYoutube'] = urlYoutube;
    data['urlTiktok'] = urlTiktok;
    data['otherChampionshipsTeams'] = otherChampionshipsTeams;
    data['teams1000Id'] = teams1000Id;
    data['isCupLeague'] = isCupLeague;
    data['isVipLeague'] = isVipLeague;
    data['countTeam'] = countTeams;
    data['isClassicLeague'] = isClassicLeague;
    data['isTeam1000League'] = isTeam1000League;

    return data;
  }

  Map<String, dynamic> toJsonWhenCloseEdit() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['whatsApp'] = whatsApp;
    data['phone'] = phone;
    data['image'] = image;
    data['description'] = description;
    data['urlFacebook'] = urlFacebook;
    data['urlTwitter'] = urlTwitter;
    data['urlInstagram'] = urlInstagram;
    data['urlYoutube'] = urlYoutube;
    data['urlTiktok'] = urlTiktok;
    data['isCupLeague'] = isCupLeague;
    data['isVipLeague'] = isVipLeague;
    data['isClassicLeague'] = isClassicLeague;
    data['isTeam1000League'] = isTeam1000League;

    return data;
  }
}
