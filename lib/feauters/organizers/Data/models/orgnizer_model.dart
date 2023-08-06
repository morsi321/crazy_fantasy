class Organizer{
  String ?id;
  String ?name;
  String ?whatsApp;
  String ?phone;
  String ?image;
  String ?description;
  String ?urlFacebook;
  String ?urlTwitter;
  String ?urlInstagram;
  String ?urlYoutube;
  String ?urlTiktok;


  Organizer({
    this.name,
    this.whatsApp,
    this.phone,
    this.image,
    this.description,
    this.urlFacebook,
    this.urlTwitter,
    this.urlInstagram,
    this.urlYoutube,
    this.urlTiktok,
  });

  Organizer.fromJson(Map<String, dynamic> json,{required String idOrganizer}) {
    id = idOrganizer;
    name = json['name'];
    whatsApp = json['whatsApp'];
    phone = json['phone'];
    image = json['image'];
    description = json['description'];
    urlFacebook = json['urlFacebook'];
    urlTwitter = json['urlTwitter'];
    urlInstagram = json['urlInstagram'];
    urlYoutube = json['urlYoutube'];
    urlTiktok = json['urlTiktok'];
  }

  Map<String, dynamic> toJson() {
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
    return data;
  }

}