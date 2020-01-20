import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/screen/home/widget/home_empty.dart';
import 'package:meteo/screen/home/widget/home_graph.dart';
import 'package:meteo/screen/weathers/bloc/weathers_bloc.dart';
import 'package:meteo/screen/weathers/bloc/weathers_state.dart';

enum _AppBarAction { myCities, comment, legend }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeathersBloc, WeathersState>(
      builder: (BuildContext context, WeathersState state) {
        final List<Weather> models =
            state is WeathersLoaded ? state.weathers : [];

        final scaffold = Scaffold(
          appBar: _buildAppBar(context, models),
          body: _buildBody(models),
        );

        if (models.length > 1) {
          return DefaultTabController(
            length: models.length,
            child: scaffold,
          );
        }

        return scaffold;
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, List<Weather> models) {
    final bool optionsEnabled = models.isNotEmpty;
    final String title = models.length == 1 ? models.first.city.name : 'Meteo';
    return AppBar(
      title: Text(title),
      actions: _buildActions(context, optionsEnabled),
      bottom: _buildTabs(models),
    );
  }

  List<Widget> _buildActions(BuildContext context, bool optionsEnabled) {
    return [
      IconButton(
        icon: const Icon(Icons.layers),
        onPressed: optionsEnabled ? _onLayersTap : null,
      ),
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: optionsEnabled ? _onRefreshTap : null,
      ),
      PopupMenuButton<_AppBarAction>(
        onSelected: (_AppBarAction action) {
          switch (action) {
            case _AppBarAction.myCities:
              Navigator.pushNamed(context, '/weathers');
              break;
            case _AppBarAction.comment:
              Navigator.pushNamed(context, '/comment');
              break;
            case _AppBarAction.legend:
              Navigator.pushNamed(context, '/legend');
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: _AppBarAction.myCities,
              child: Text('Moje miasta'),
            ),
            const PopupMenuItem(
              value: _AppBarAction.comment,
              child: Text('Komentarz synoptyka'),
            ),
            const PopupMenuItem(
              value: _AppBarAction.legend,
              child: Text('Legenda'),
            ),
          ];
        },
      ),
    ];
  }

  TabBar _buildTabs(List<Weather> models) {
    if (models.length < 2) return null;

    return TabBar(
      tabs: models.map((Weather model) {
        return Tab(child: Text(model.city.name.toUpperCase()));
      }).toList(),
    );
  }

  void _onLayersTap() {
    print('_onLayersTap');
  }

  void _onRefreshTap() {
    print('_onRefreshTap');
  }

  Widget _buildBody(List<Weather> models) {
    if (models.length == 0) {
      return HomeEmpty();
    } else if (models.length == 1) {
      final url = models.first.graphs[Weather.MODEL_UM];

      return HomeGraph(weatherUrl: url);
    } else {
      return TabBarView(
          children: models.map((Weather model) {
        final url = models.first.graphs[Weather.MODEL_UM];

        return HomeGraph(weatherUrl: url);
      }).toList());
    }
  }
}
