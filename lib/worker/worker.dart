import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  String location;

  Worker({required this.location});

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon; // Added from old code

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=f89851b30612858c81c4d372f861a081&time/Asia/Kolkata"));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        // Getting temp, Humidity
        Map temp_data = data['main'];
        Map wind = data['wind'];
        double getAir_speed = wind["speed"] / 0.27778;
        String getHumidity = temp_data['humidity'].toString();
        double getTemp = temp_data['temp'] - 273.15;

        // Getting Description
        List weather_data = data['weather'];
        Map weather_main_data = weather_data[0];
        String getMain_des = weather_main_data['main'];
        String getDesc = weather_main_data["description"];
        String getIcon = weather_main_data["icon"].toString(); // Added from old code

        // Assigning the values
        temp = getTemp.toString(); //C
        humidity = getHumidity; //%
        air_speed = getAir_speed.toString(); //km/hr
        description = getDesc;
        main = getMain_des;
        icon = getIcon; // Added from old code
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e); // Added from old code for debugging
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d"; // Added from old code for default icon
    }
  }
}
