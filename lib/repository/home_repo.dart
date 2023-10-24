import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/home/home_page.dart';
import 'package:weather_app/home/widgets/notify_dialog.dart';
import 'package:weather_app/model/daily_model.dart';
import 'package:weather_app/model/hourly_model.dart';

import '../model/current_model.dart';
import '../model/temp_model.dart';

class HomeRepo {
  final dio = Dio();

  final _path = 'https://ai-weather-by-meteosource.p.rapidapi.com';

  final _headers = <String, dynamic>{
    "content-type": "application/json",
    "X-RapidAPI-Key": "bb8d133ae9msh64adfa2cdd2e5dcp1c8a22jsna434ee99e131",
    "X-RapidAPI-Host": "ai-weather-by-meteosource.p.rapidapi.com"
  };

  BehaviorSubject<List<TempModel>> listDataTemp = BehaviorSubject();

  BehaviorSubject<CurrentWeatherModel> currentTemp = BehaviorSubject();
  BehaviorSubject<HourlyWeatherModel> hourlyTemp = BehaviorSubject();
  BehaviorSubject<DailyWeatherModel> dailyTemp = BehaviorSubject();
  BehaviorSubject<String> errorHandle = BehaviorSubject();
  BehaviorSubject<String> error2Handle = BehaviorSubject();

  void getTempWithPlace(BuildContext context, {String? place}) async {
    Response response;
    List<TempModel> lsData = [];
    try {
      response = await dio.get('$_path/find_places',
          queryParameters: {
            'text': place,
          },
          options: Options(headers: _headers));
      print('${response.statusCode}');
      if ((response.data as List).isNotEmpty) {
        lsData = (response.data as List)
            .map((item) => TempModel.fromJson(item))
            .toList();

        getCurrentWeather(placeId: lsData.first.placeId);
        getHourlyWeather(place: lsData.first.placeId);
        getDailyWeather(place: lsData.first.placeId);
        listDataTemp.sink.add(lsData);
      } else {
        _showMyDialog('Not Found Data!!!', context);
      }
    } on DioException catch (e) {
      print(e.message);
      _showMyDialog('${e.message} Please check this on README file', context);
    }
  }

  Future<void> _showMyDialog(String msg, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getCurrentWeather({String? placeId}) async {
    Response response;
    try {
      response = await dio.get('$_path/current',
          queryParameters: {
            'place_id': placeId,
          },
          options: Options(headers: _headers));
      print(response.data.toString());

      currentTemp.sink.add(CurrentWeatherModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.message);
      errorHandle.sink.add(e.message ?? '');
    }
  }

  void getHourlyWeather({String? place}) async {
    Response response;

    try {
      response = await dio.get('$_path/hourly',
          queryParameters: {
            'place_id': place,
          },
          options: Options(headers: _headers));
      print(response.data.toString());

      hourlyTemp.sink.add(HourlyWeatherModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.message);
      errorHandle.sink.add(e.message ?? '');
    }
  }

  void getDailyWeather({String? place}) async {
    Response response;

    try {
      response = await dio.get('$_path/daily',
          queryParameters: {
            'place_id': place,
          },
          options: Options(headers: _headers));
      print(response.data.toString());

      dailyTemp.sink.add(DailyWeatherModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.message);
      errorHandle.sink.add(e.message ?? '');
    }
  }

  void disposeStream() {
    listDataTemp.close();
    currentTemp.close();
    hourlyTemp.close();
    dailyTemp.close();
    errorHandle.close();
    error2Handle.close();
  }
}
