import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/home/bloc/home_bloc.dart';
import 'package:meteo/screen/home/bloc/home_event.dart';
import 'package:meteo/screen/home/bloc/home_state.dart';
import 'package:meteo/screen/home/widget/home_app_bar.dart';
import 'package:meteo/screen/home/widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) {
        return HomeBloc(RepositoryProvider.of<WeatherRepository>(context))
          ..add(LoadHome());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          final List<Weather> models = _getModelsFromState(state);

          final Scaffold scaffold = Scaffold(
            appBar: HomeAppBarBuilder.build(context, models),
            body: HomeBody(),
          );

          if (models.length > 1) {
            return DefaultTabController(
              length: models.length,
              child: scaffold,
            );
          }
          return scaffold;
        },
      ),
    );
  }

  List<Weather> _getModelsFromState(HomeState state) {
    return state is HomeLoaded ? state.weathers : [];
  }
}
