import 'package:flutter/material.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/find/find_screen.dart';
import 'package:meteo/screen/home/home_screen.dart';
import 'package:meteo/screen/weathers/weathers_screen.dart';

class App extends StatelessWidget {
  final WeatherRepository repository;

  const App({Key key, @required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meteo',
      routes: {
        '/': (_) => HomeScreen(),
        '/weathers': (_) => WeathersScreen(),
        '/find': (_) => FindScreen(),
      },
      initialRoute: '/',
    );
  }
}
