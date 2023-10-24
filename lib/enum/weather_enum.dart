import 'package:flutter/material.dart';

enum WeatherEnum { sun, rainy, thunder, cloudy }

class WeatherName {
  static const String SUN = 'sunny';
  static const String CLOUDY = 'cloudy';
  static const String RAIN = 'rain';
  static const String THUNDER = 'thunderstorm';
  static const String OVERCAST = 'overcast';
}

extension WeatherEnumExtension on WeatherEnum {
  Image get iconUrl => _getIcon();

  String get name => _getName();

  Image _getIcon() {
    switch (this) {
      case WeatherEnum.sun:
        return Image.asset('Assets/images/sun.png');
      case WeatherEnum.cloudy:
        return Image.asset('Assets/images/cloudy_day.png');
      case WeatherEnum.thunder:
        return Image.asset('Assets/images/thunderstorm.png');
      case WeatherEnum.rainy:
        return Image.asset('Assets/images/rainy_day.png');
    }
  }

  String _getName() {
    switch (this) {
      case WeatherEnum.sun:
        return WeatherName.SUN;
      case WeatherEnum.cloudy:
        return WeatherName.CLOUDY;
      case WeatherEnum.thunder:
        return WeatherName.THUNDER;
      case WeatherEnum.rainy:
        return WeatherName.RAIN;
    }
  }
}
