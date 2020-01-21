import 'package:flutter/material.dart';
import 'package:meteo/common/meteo_localizations.dart';

class WeathersListEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(MeteoLocalizations.of(context).citiesEmpty));
  }
}
