import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/screen/app_routes.dart';
import 'package:meteo/screen/comment/comment_screen.dart';
import 'package:meteo/screen/find/find_screen.dart';
import 'package:meteo/screen/home/home_screen.dart';
import 'package:meteo/screen/legend/legend_screen.dart';
import 'package:meteo/screen/weathers/weathers_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const MeteoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pl', ''),
        const Locale('sv', ''),
        const Locale('nb', ''),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Meteo',
      routes: {
        AppRoutes.HOME: (_) => HomeScreen(),
        AppRoutes.WEATHERS: (_) => WeathersScreen(),
        AppRoutes.FIND: (_) => FindScreen(),
        AppRoutes.LEGEND: (_) => LegendScreen(),
        AppRoutes.COMMENT: (_) => CommentScreen(),
      },
      initialRoute: AppRoutes.HOME,
    );
  }
}
