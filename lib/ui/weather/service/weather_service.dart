import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static const BaseUrl = 'http://api.openweathermap.org/data/2.5/weather';
 // http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=132b326012c5b061584dc9eee3b41430
  late final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final res = await http.get(Uri.parse('$BaseUrl?q=$cityName&APPID=$apiKey&units=metric'));
    //final res = await http.get(Uri.parse('$BaseUrl?lat=44.34&lon=10.99&appid=$apiKey'));

    if(res.statusCode == 200){
      return WeatherModel.fromJson(jsonDecode(res.body));
    }else{
      throw Exception('failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
   LocationPermission permission = await Geolocator.checkPermission();
   if(permission == LocationPermission.denied){
     permission = await Geolocator.requestPermission();
   }

   Position position = await Geolocator.getCurrentPosition(
     desiredAccuracy: LocationAccuracy.high
   );
   List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
   String? city = placeMarks[0].locality;
   return city ?? "";
  }
}