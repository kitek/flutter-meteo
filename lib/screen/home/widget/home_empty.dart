import 'package:flutter/material.dart';
import 'package:meteo/screen/app_routes.dart';

class HomeEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Brak meteogramu'),
        RaisedButton(
          child: Text('Wybierz miasto'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.FIND),
        ),
      ],
    );
  }
}
