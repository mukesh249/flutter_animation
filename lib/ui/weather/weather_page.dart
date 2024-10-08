import 'package:flutter/material.dart';
import 'package:flutter_animation/common/clipper.dart';
import 'package:flutter_animation/common/size_config.dart';
import 'package:flutter_animation/common/utils.dart';
import 'package:flutter_animation/ui/weather/model/weather_model.dart';
import 'package:flutter_animation/ui/weather/service/weather_service.dart';
import 'package:flutter_animation/widgets/neo_button.dart';
import 'package:lottie/lottie.dart';

import '../../common/theme.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService("132b326012c5b061584dc9eee3b41430");
  WeatherModel? weatherModel;

  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final weather = await weatherService.getWeather('jaipur');
      setState(() {
        weatherModel = weather;
      });
    } catch (e) {
      print("$e");
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/weather/sun.json';
    switch (mainCondition) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/weather/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather/rain.json';
      case 'thunderstorm':
        return 'assets/weather/thunder.json';
      case 'clear':
        return 'assets/weather/sun.json';
      default:
        return 'assets/weather/sun.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weatherModel?.cityName ?? "Loading city...",
                style: textStyle(fontSize: 40, fontWeight: FontWeight.bold).copyWith(color: Colors.yellow)),
            Text(weatherModel?.condition ?? "Loading city...",
                style: textStyle(fontSize: 12, fontWeight: FontWeight.bold).copyWith(color: Colors.yellow)),
            Stack(
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    width: AppSizes.blockSizeHorizontal * 57,
                    height: AppSizes.blockSizeVertical * 25,
                    margin: const EdgeInsets.only(top: 80),
                    /*  width: 50,
                    height: 50,*/
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                ),
                Lottie.asset(
                    getWeatherAnimation(weatherModel?.condition.toLowerCase())),

              ],
            ),
            Text("${weatherModel?.temperature.round()}°C",
                style: textStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            NeoButton(),

          ],
        ),
      ),
    );
  }
}
