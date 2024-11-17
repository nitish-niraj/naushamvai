import 'package:flutter/material.dart';
import 'package:maushamvani/activity/home.dart';
import 'package:maushamvani/activity/loading.dart';
import 'package:maushamvani/activity/location.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) =>  const Home(),
      '/location': (context) => Location(),
    },
  ));
}
