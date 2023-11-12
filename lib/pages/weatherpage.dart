import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/api/weathermodel.dart';
import 'package:weatherapp/api/weatherservice.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherservice =
      Weatherservice(api_key: 'b22204e231aed843b0f7e2fa95d17f6c');
  Weathermodel? _weathermodel;

  _featchweather() async {
    String Cityname = await _weatherservice.getlocation();

    try {
      final weather = await _weatherservice.getweather(Cityname);
      setState(() {
        _weathermodel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getanimation(String? maincondition) {
    if (maincondition == null) return 'lib/assets/sunny.json';
    switch (maincondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/rainy.json';
      case 'thuderstorm':
        return 'lib/assets/thunder.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _featchweather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 142, 14, 164),
      ),
      body: Column(
        children: [
          Center(),
          SizedBox(
            height: 180,
          ),
          Text(_weathermodel?.cityname ?? "loading..."),
          Lottie.asset(getanimation(_weathermodel?.condition)),
          Text('${_weathermodel?.temp.round()}*c' ?? "loading..."),
          SizedBox(
            height: 20,
          ),
          Text(_weathermodel?.condition ?? "loading..."),
        ],
      ),
    );
  }
}
