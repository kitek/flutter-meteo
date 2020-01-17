import 'package:flutter/material.dart';

class HomeEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Brak meteogramu'),
        RaisedButton(
          child: Text('Wybierz miasto'),
          onPressed: () => Navigator.pushNamed(context, '/find'),
        ),
      ],
    );
  }
}
