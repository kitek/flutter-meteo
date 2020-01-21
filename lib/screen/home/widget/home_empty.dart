import 'package:flutter/material.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/screen/app_routes.dart';

class HomeEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            MeteoLocalizations.of(context).noGraph,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 8.0),
          RaisedButton(
            child: Text(MeteoLocalizations.of(context).chooseCity),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.FIND),
          ),
        ],
      ),
    );
  }
}
