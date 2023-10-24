import 'hourly_model.dart';

class DailyWeatherModel {
  String? lat;
  String? lon;
  int? elevation;
  String? units;
  Daily? daily;

  DailyWeatherModel(
      {this.lat, this.lon, this.elevation, this.units, this.daily});

  DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    elevation = json['elevation'];
    units = json['units'];
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['elevation'] = this.elevation;
    data['units'] = this.units;
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class Daily {
  List<Data>? data;

  Daily({this.data});

  Daily.fromJson(Map<String, dynamic> json) {
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
  String? day;
  String? weather;
  int? icon;
  String? summary;
  int? predictability;
  double? temperature;
  double? temperatureMin;
  double? temperatureMax;
  double? feelsLike;
  double? feelsLikeMin;
  double? feelsLikeMax;
  double? windChill;
  double? windChillMin;
  double? windChillMax;
  double? dewPoint;
  double? dewPointMin;
  double? dewPointMax;
  Wind? wind;
  int? cloudCover;
  int? pressure;
  Precipitation? precipitation;
  Probability? probability;
  double? ozone;
  int? humidity;
  double? visibility;

  Data(
      {this.day,
      this.weather,
      this.icon,
      this.summary,
      this.predictability,
      this.temperature,
      this.temperatureMin,
      this.temperatureMax,
      this.feelsLike,
      this.feelsLikeMin,
      this.feelsLikeMax,
      this.windChill,
      this.windChillMin,
      this.windChillMax,
      this.dewPoint,
      this.dewPointMin,
      this.dewPointMax,
      this.wind,
      this.cloudCover,
      this.pressure,
      this.precipitation,
      this.probability,
      this.ozone,
      this.humidity,
      this.visibility});

  Data.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    weather = json['weather'];
    icon = json['icon'];
    summary = json['summary'];
    predictability = json['predictability'];
    temperature = json['temperature'];
    temperatureMin = json['temperature_min'];
    temperatureMax = json['temperature_max'];
    feelsLike = json['feels_like'];
    feelsLikeMin = json['feels_like_min'];
    feelsLikeMax = json['feels_like_max'];
    windChill = json['wind_chill'];
    windChillMin = json['wind_chill_min'];
    windChillMax = json['wind_chill_max'];
    dewPoint = json['dew_point'];
    dewPointMin = json['dew_point_min'];
    dewPointMax = json['dew_point_max'];
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
    humidity = json['humidity'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['weather'] = this.weather;
    data['icon'] = this.icon;
    data['summary'] = this.summary;
    data['predictability'] = this.predictability;
    data['temperature'] = this.temperature;
    data['temperature_min'] = this.temperatureMin;
    data['temperature_max'] = this.temperatureMax;
    data['feels_like'] = this.feelsLike;
    data['feels_like_min'] = this.feelsLikeMin;
    data['feels_like_max'] = this.feelsLikeMax;
    data['wind_chill'] = this.windChill;
    data['wind_chill_min'] = this.windChillMin;
    data['wind_chill_max'] = this.windChillMax;
    data['dew_point'] = this.dewPoint;
    data['dew_point_min'] = this.dewPointMin;
    data['dew_point_max'] = this.dewPointMax;
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
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    return data;
  }
}

class Wind {
  double? speed;
  double? gusts;
  String? dir;
  int? angle;

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
