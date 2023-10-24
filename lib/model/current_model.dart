class CurrentWeatherModel {
  String? lat;
  String? lon;
  int? elevation;
  String? timezone;
  String? units;
  Current? current;

  CurrentWeatherModel(
      {this.lat,
      this.lon,
      this.elevation,
      this.timezone,
      this.units,
      this.current});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    elevation = json['elevation'];
    timezone = json['timezone'];
    units = json['units'];
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['elevation'] = this.elevation;
    data['timezone'] = this.timezone;
    data['units'] = this.units;
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

class Current {
  String? icon;
  int? iconNum;
  String? summary;
  double? temperature;
  double? feelsLike;
  double? windChill;
  double? dewPoint;
  Wind? wind;
  Precipitation? precipitation;
  int? cloudCover;
  double? ozone;
  int? pressure;
  double? uvIndex;
  int? humidity;
  double? visibility;

  Current(
      {this.icon,
      this.iconNum,
      this.summary,
      this.temperature,
      this.feelsLike,
      this.windChill,
      this.dewPoint,
      this.wind,
      this.precipitation,
      this.cloudCover,
      this.ozone,
      this.pressure,
      this.uvIndex,
      this.humidity,
      this.visibility});

  Current.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    iconNum = json['icon_num'];
    summary = json['summary'];
    temperature = json['temperature'];
    feelsLike = json['feels_like'];
    windChill = json['wind_chill'];
    dewPoint = json['dew_point'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    precipitation = json['precipitation'] != null
        ? new Precipitation.fromJson(json['precipitation'])
        : null;
    cloudCover = json['cloud_cover'];
    ozone = json['ozone'];
    pressure = json['pressure'];
    uvIndex = json['uv_index'];
    humidity = json['humidity'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['icon_num'] = this.iconNum;
    data['summary'] = this.summary;
    data['temperature'] = this.temperature;
    data['feels_like'] = this.feelsLike;
    data['wind_chill'] = this.windChill;
    data['dew_point'] = this.dewPoint;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.precipitation != null) {
      data['precipitation'] = this.precipitation!.toJson();
    }
    data['cloud_cover'] = this.cloudCover;
    data['ozone'] = this.ozone;
    data['pressure'] = this.pressure;
    data['uv_index'] = this.uvIndex;
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    return data;
  }
}

class Wind {
  double? speed;
  double? gusts;
  int? angle;
  String? dir;

  Wind({this.speed, this.gusts, this.angle, this.dir});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    gusts = json['gusts'];
    angle = json['angle'];
    dir = json['dir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['gusts'] = this.gusts;
    data['angle'] = this.angle;
    data['dir'] = this.dir;
    return data;
  }
}

class Precipitation {
  double? total;
  String? type;

  Precipitation({this.total, this.type});

  Precipitation.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['type'] = this.type;
    return data;
  }
}
