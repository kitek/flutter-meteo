import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/common/bloc_delegate.dart';
import 'package:meteo/repository/datasource/weather_api_client.dart';
import 'package:meteo/repository/datasource/weather_dao.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/app.dart';
import 'package:meteo/screen/weathers/bloc/weathers_bloc.dart';
import 'package:meteo/screen/weathers/bloc/weathers_event.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final repository = WeatherRepository(
    WeatherDao(),
    WeatherApiClient(httpClient: http.Client()),
  );

  runApp(BlocProvider<WeathersBloc>(
    create: (_) => WeathersBloc(repository: repository)..add(LoadWeathers()),
    child: App(repository: repository),
  ));
}
