import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/common/bloc_delegate.dart';
import 'package:meteo/repository/datasource/weather_api_client.dart';
import 'package:meteo/repository/datasource/weather_dao.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  return runApp(
    RepositoryProvider(
      create: (_) => WeatherRepository(
        WeatherDao(),
        WeatherApiClient(httpClient: http.Client()),
      ),
      child: App(),
    ),
  );
}
