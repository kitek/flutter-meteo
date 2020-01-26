import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/screen/home/bloc/home_bloc.dart';
import 'package:meteo/screen/home/bloc/home_state.dart';
import 'package:meteo/screen/home/widget/home_empty.dart';
import 'package:meteo/screen/home/widget/home_graph.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) _showSnackBar(context);
      },
      condition: (previous, current) {
        return current is HomeLoaded && current.showSnackBar;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) => _buildBodyChild(state),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(MeteoLocalizations.of(context).refreshed),
    ));
  }

  Widget _buildBodyChild(HomeState state) {
    if (state is HomeLoading) {
      return Align(child: CircularProgressIndicator());
    } else {
      final List<Weather> models = state is HomeLoaded ? state.weathers : [];
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
}
