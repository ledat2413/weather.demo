class TempModel {
  String? name;
  String? placeId;
  String? admArea1;
  String? country;
  String? lat;
  String? lon;
  String? timezone;
  String? type;

  TempModel(
      {this.name,
      this.placeId,
      this.admArea1,
      this.country,
      this.lat,
      this.lon,
      this.timezone,
      this.type});

  TempModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['place_id'];
    admArea1 = json['adm_area1'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['place_id'] = this.placeId;
    data['adm_area1'] = this.admArea1;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['type'] = this.type;
    return data;
  }
}
