import 'package:flutter/material.dart';

class HomeEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Brak meteogramu'),
        RaisedButton(
          child: Text('Wybierz miasto'),
          onPressed: () => Navigator.pushNamed(context, '/find'),
        ),
      ],
    );
  }
}
