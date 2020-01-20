import 'package:flutter/material.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/app_routes.dart';
import 'package:meteo/screen/comment/comment_screen.dart';
import 'package:meteo/screen/find/find_screen.dart';
import 'package:meteo/screen/home/home_screen.dart';
import 'package:meteo/screen/legend/legend_screen.dart';
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
        AppRoutes.HOME: (_) => HomeScreen(),
        AppRoutes.WEATHERS: (_) => WeathersScreen(),
        AppRoutes.FIND: (_) => FindScreen(),
        AppRoutes.LEGEND: (_) => LegendScreen(),
        AppRoutes.COMMENT: (_) => CommentScreen(repository: repository),
      },
      initialRoute: '/',
    );
  }
}
