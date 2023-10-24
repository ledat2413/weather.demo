class HourlyWeatherModel {
  String? lat;
  String? lon;
  int? elevation;
  String? timezone;
  String? units;
  Hourly? hourly;

  HourlyWeatherModel(
      {this.lat,
      this.lon,
      this.elevation,
      this.timezone,
      this.units,
      this.hourly});

  HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    elevation = json['elevation'];
    timezone = json['timezone'];
    units = json['units'];
    hourly =
        json['hourly'] != null ? new Hourly.fromJson(json['hourly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['elevation'] = this.elevation;
    data['timezone'] = this.timezone;
    data['units'] = this.units;
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    return data;
  }
}

class Hourly {
  List<Data>? data;

  Hourly({this.data});

  Hourly.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? weather;
  int? icon;
  String? summary;
  double? temperature;
  double? feelsLike;
  double? windChill;
  double? dewPoint;
  Wind? wind;
  int? cloudCover;
  int? pressure;
  Precipitation? precipitation;
  Probability? probability;
  double? ozone;
  double? uvIndex;
  int? humidity;
  double? visibility;

  Data(
      {this.date,
      this.weather,
      this.icon,
      this.summary,
      this.temperature,
      this.feelsLike,
      this.windChill,
      this.dewPoint,
      this.wind,
      this.cloudCover,
      this.pressure,
      this.precipitation,
      this.probability,
      this.ozone,
      this.uvIndex,
      this.humidity,
      this.visibility});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weather = json['weather'];
    icon = json['icon'];
    summary = json['summary'];
    temperature = json['temperature'];
    feelsLike = json['feels_like'];
    windChill = json['wind_chill'];
    dewPoint = json['dew_point'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    cloudCover = json['cloud_cover'];
    pressure = json['pressure'];
    precipitation = json['precipitation'] != null
        ? new Precipitation.fromJson(json['precipitation'])
        : null;
    probability = json['probability'] != null
        ? new Probability.fromJson(json['probability'])
        : null;
    ozone = json['ozone'];
    uvIndex = json['uv_index'];
    humidity = json['humidity'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['weather'] = this.weather;
    data['icon'] = this.icon;
    data['summary'] = this.summary;
    data['temperature'] = this.temperature;
    data['feels_like'] = this.feelsLike;
    data['wind_chill'] = this.windChill;
    data['dew_point'] = this.dewPoint;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    data['cloud_cover'] = this.cloudCover;
    data['pressure'] = this.pressure;
    if (this.precipitation != null) {
      data['precipitation'] = this.precipitation!.toJson();
    }
    if (this.probability != null) {
      data['probability'] = this.probability!.toJson();
    }
    data['ozone'] = this.ozone;
    data['uv_index'] = this.uvIndex;
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    return data;
  }
}

class Wind {
  double? speed;
  double? gusts;
  String? dir;
  num? angle;

  Wind({this.speed, this.gusts, this.dir, this.angle});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    gusts = json['gusts'];
    dir = json['dir'];
    angle = json['angle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['gusts'] = this.gusts;
    data['dir'] = this.dir;
    data['angle'] = this.angle;
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

class Probability {
  num? precipitation;
  num? storm;
  num? freeze;

  Probability({this.precipitation, this.storm, this.freeze});

  Probability.fromJson(Map<String, dynamic> json) {
    precipitation = json['precipitation'];
    storm = json['storm'];
    freeze = json['freeze'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precipitation'] = this.precipitation;
    data['storm'] = this.storm;
    data['freeze'] = this.freeze;
    return data;
  }
}
