import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/enum/weather_enum.dart';
import 'package:weather_app/home/widgets/notify_dialog.dart';
import 'package:weather_app/model/hourly_model.dart';

import 'package:weather_app/repository/home_repo.dart';

import '../model/current_model.dart';
import '../model/daily_model.dart';
import '../model/temp_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeRepo _homeRepo = HomeRepo();

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateFormat hoursFormat = DateFormat('ha');
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _homeRepo.getTempWithPlace(context, place: 'ho chi minh');
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _homeRepo.disposeStream();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TempModel>>(
        stream: _homeRepo.listDataTemp.stream,
        builder: (context, snapshot) {
          var item = snapshot.data?.first;
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              StreamBuilder<CurrentWeatherModel>(
                  stream: _homeRepo.currentTemp.stream,
                  builder: (context, snapshot) {
                    var itemCurrent = snapshot.data;
                    return itemCurrent != null
                        ? _geBgWeather(
                            itemCurrent.current?.summary?.toLowerCase())
                        : const SizedBox();
                  }),
              item != null ? _buildBody(item) : const SizedBox(),
              // StreamBuilder(
              //     stream: _homeRepo.errorHandle.stream,
              //     builder: (context, snapshot) {
              //       var errMsg = snapshot.data ?? '';
              //       return errMsg.isNotEmpty
              //           ? _showMyDialog()
              //           : const SizedBox.shrink();
              //     }),
            ],
          );
        });
  }

  Scaffold _buildBody(TempModel? item) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: StreamBuilder<CurrentWeatherModel>(
              stream: _homeRepo.currentTemp.stream,
              builder: (context, snapshotCurrent) {
                var itemCurrent = snapshotCurrent.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSearch(),
                    const SizedBox(height: 16),
                    _buildText(
                        text: '${item?.name?.toUpperCase()}',
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    _buildText(
                        text:
                            '${itemCurrent?.current?.temperature.toString()}°C',
                        textStyle: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildText(
                            text: itemCurrent?.lat,
                            textStyle: const TextStyle(
                                fontSize: 13, color: Colors.white)),
                        const SizedBox(
                          width: 12,
                        ),
                        _buildText(
                            text: itemCurrent?.lon,
                            textStyle: const TextStyle(
                                fontSize: 13, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildWeatherAround(),
                    _buildTenDayForeCast()
                  ],
                );
              }),
        ),
      )),
    );
  }

  TextFormField _buildSearch() {
    return TextFormField(
      controller: _searchController,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        hintText: 'City name,...',
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        prefixIcon: IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 30),
          onPressed: () {
            // _homeRepo.openSearch.sink.add(true);
            _homeRepo.getTempWithPlace(context, place: _searchController.text);
          },
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildTenDayForeCast() {
    return StreamBuilder<DailyWeatherModel>(
        stream: _homeRepo.dailyTemp,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            return Container(
              margin: const EdgeInsets.only(top: 26),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '10 day forecast'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Divider(),
                  ListView.separated(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (c, index) => const Divider(),
                      itemBuilder: (c, index) {
                        var item = data.daily?.data?[index];

                        var ngay = dateFormat
                            .format(DateTime.parse(item?.day ?? '23/10/2023'));
                        var percent = (item?.temperatureMax ?? 0) / 40;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 90,
                                child: _buildText(
                                    text: ngay,
                                    textStyle: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                            _getImageWeather(item?.summary?.toLowerCase()),
                            const SizedBox(
                              width: 16,
                            ),
                            _buildText(
                                text: '${item?.temperatureMin.toString()}°C',
                                textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            LinearPercentIndicator(
                              width: 75.0,
                              lineHeight: 6.0,
                              percent: percent,
                              progressColor: Colors.red,
                            ),
                            _buildText(
                                text: '${item?.temperatureMax.toString()}°C',
                                textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        );
                      })
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget _buildWeatherAround({String? title}) {
    return StreamBuilder<HourlyWeatherModel>(
        stream: _homeRepo.hourlyTemp.stream,
        builder: (context, snapshot) {
          var data = snapshot.data;

          return data != null
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        title ?? 'Weather for the next 5 hours',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5, (index) => _buildInfoWeatherAround(index, data)),
                      )
                    ],
                  ),
                )
              : const SizedBox();
        });
  }

  Widget _buildInfoWeatherAround(int index, HourlyWeatherModel data) {
    var item = data.hourly?.data?[index];
    var hour = '23/10/2023 17:21';
    if (item?.date != null) {
      hour =
          hoursFormat.format(DateTime.parse(item?.date ?? '23/10/2023 17:21'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          hour,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        _getImageWeather(item?.summary?.toLowerCase()),
        const SizedBox(height: 16),
        Text(
          '${item?.temperature.toString()}°C',
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Text _buildText({String? text, TextStyle? textStyle}) {
    return Text(
      text ?? 'Hà Nội',
      style: textStyle ??
          const TextStyle(
            fontSize: 16,
          ),
    );
  }

  Widget _geBgWeather(String? weather) {
    if (weather?.contains(WeatherName.SUN) == true) {
      return Image.asset(
        'assets/images/sun_bg.jpeg',
        fit: BoxFit.fill,
      );
    } else if (weather?.contains(WeatherName.RAIN) == true) {
      return Image.asset(
        'assets/images/rainy_bg.jpeg',
        fit: BoxFit.fill,
      );
    } else if (weather?.contains(WeatherName.CLOUDY) == true ||
        weather?.contains(WeatherName.OVERCAST) == true) {
      return Image.asset(
        'assets/images/cloud_bg.jpeg',
        fit: BoxFit.fill,
      );
    } else if (weather?.contains(WeatherName.THUNDER) == true) {
      return Image.asset(
        'assets/images/thunder_bg.jpeg',
        fit: BoxFit.fill,
      );
    }
    return const SizedBox();
  }

  Widget _getImageWeather(String? weather) {
    if (weather?.contains(WeatherName.SUN) == true) {
      return Image.asset(
        'assets/images/sun.png',
        height: 20,
        width: 20,
        fit: BoxFit.cover,
      );
    } else if (weather?.contains(WeatherName.RAIN) == true) {
      return Image.asset(
        'assets/images/rainy_day.png',
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      );
    } else if (weather?.contains(WeatherName.CLOUDY) == true ||
        weather?.contains(WeatherName.OVERCAST) == true) {
      return Image.asset(
        'assets/images/cloudy_day.png',
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      );
    } else if (weather?.contains(WeatherName.THUNDER) == true) {
      return Image.asset(
        'assets/images/thunderstorm.png',
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      );
    }
    return const SizedBox();
  }
}
