import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'weathermodel.dart';
import 'package:http/http.dart' as http;

class Weatherservice {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String api_key;

  Weatherservice({required this.api_key});

  Future<Weathermodel> getweather(String cityname) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityname&appid=$api_key&units=metric'));

    if (response.statusCode == 200) {
      return Weathermodel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<String> getlocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? '';
  }
}
