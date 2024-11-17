import 'package:flutter/material.dart';
import 'package:maushamvani/activity/home.dart';
import 'package:maushamvani/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String icon; // Added for icon value
  String city = "patna"; // Default city value

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon; // Updated for icon value

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "main_value": main,
        "icon_value": icon, // Added for icon value
        "city_value": city, // Added city value to arguments
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map search = ModalRoute.of(context)?.settings.arguments as Map? ?? {}; // Updated for search functionality
    if (search.isNotEmpty) {
      city = search['searchText'] ?? city; // Get city from search or use default
    }
    startApp(city); // Start app with the city value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Updated for better UI
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 180,), // Adjusted spacing
              Image.asset("images/N1.png", height: 240, width: 240,), // Updated image asset
              Text("Maushamvani",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
              SizedBox(height: 10,),
              Text("Made by Niraj",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),),
              SizedBox(height: 30,),
              SpinKitSpinningLines(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
