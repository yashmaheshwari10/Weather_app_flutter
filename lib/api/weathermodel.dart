class Weathermodel {
  final String cityname;
  final double temp;
  final String condition;

  Weathermodel(
      {required this.cityname, required this.temp, required this.condition});

  factory Weathermodel.fromJson(Map<String, dynamic> json) {
    return Weathermodel(
        cityname: json['name'],
        temp: json['main']['temp'],
        condition: json['weather'][0]['main']);
  }
}
