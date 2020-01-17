import 'package:flutter/material.dart';
import 'package:meteo/screen/home/widget/home_empty.dart';

enum AppBarAction { myCities, comment, legend }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: _buildActions(context),
      ),
      body: HomeEmpty(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.layers),
        onPressed: () {
          print('pressed!');
        },
      ),
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {},
      ),
      PopupMenuButton<AppBarAction>(
        onSelected: (AppBarAction action) {
          switch (action) {
            case AppBarAction.myCities:
              Navigator.pushNamed(context, '/weathers');
              break;
            case AppBarAction.comment:
              Navigator.pushNamed(context, '/comment');
              break;
            case AppBarAction.legend:
              Navigator.pushNamed(context, '/legend');
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: AppBarAction.myCities,
              child: Text('Moje miasta'),
            ),
            PopupMenuItem(
              value: AppBarAction.comment,
              child: Text('Komentarz synoptyka'),
            ),
            PopupMenuItem(
              value: AppBarAction.legend,
              child: Text('Legenda'),
            ),
          ];
        },
      ),
    ];
  }
}
