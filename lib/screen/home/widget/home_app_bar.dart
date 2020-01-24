import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/screen/app_routes.dart';
import 'package:meteo/screen/home/bloc/home_bloc.dart';
import 'package:meteo/screen/home/bloc/home_event.dart';

enum _AppBarAction { myWeathers, comment, legend }

class HomeAppBarBuilder {
  static AppBar build(BuildContext context, List<Weather> models) {
    final bool optionsEnabled = models.isNotEmpty;
    final String title = models.length == 1
        ? models.first.city.name
        : MeteoLocalizations.of(context).appName;

    return AppBar(
      title: Text(title),
      actions: _buildActions(context, optionsEnabled),
      bottom: _buildTabs(models),
    );
  }

  static List<Widget> _buildActions(BuildContext context, bool optionsEnabled) {
    return [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: optionsEnabled
            ? () => BlocProvider.of<HomeBloc>(context).add(RefreshHome())
            : null,
      ),
      PopupMenuButton<_AppBarAction>(
        onSelected: (_AppBarAction action) {
          switch (action) {
            case _AppBarAction.myWeathers:
              Navigator.pushNamed(context, AppRoutes.WEATHERS);
              break;
            case _AppBarAction.comment:
              Navigator.pushNamed(context, AppRoutes.COMMENT);
              break;
            case _AppBarAction.legend:
              Navigator.pushNamed(context, AppRoutes.LEGEND);
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: _AppBarAction.myWeathers,
              child: Text(MeteoLocalizations.of(context).myCities),
            ),
            PopupMenuItem(
              value: _AppBarAction.comment,
              child: Text(MeteoLocalizations.of(context).comment),
            ),
            PopupMenuItem(
              value: _AppBarAction.legend,
              child: Text(MeteoLocalizations.of(context).legend),
            ),
          ];
        },
      ),
    ];
  }

  static TabBar _buildTabs(List<Weather> models) {
    if (models.length < 2) return null;

    return TabBar(
      tabs: models.map((Weather model) {
        return Tab(child: Text(model.city.name.toUpperCase()));
      }).toList(),
    );
  }
}
