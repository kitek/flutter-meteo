import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/datasource/weather_api_client.dart';
import 'package:meteo/repository/datasource/weather_dao.dart';
import 'package:rxdart/rxdart.dart';

class WeatherRepository {
  final WeatherDao _dao;
  final WeatherApiClient _apiClient;
  final BehaviorSubject<List<Weather>> _weathers;

  List<Country> _countriesCache = [];

  WeatherRepository(this._dao, this._apiClient)
      : assert(_dao != null),
        assert(_apiClient != null),
        _weathers = BehaviorSubject<List<Weather>>();

  Stream<List<Weather>> get savedWeathers {
    if (!_weathers.hasValue) listSavedWeathers();

    return _weathers;
  }

  Future<List<Weather>> listSavedWeathers() async {
    final List<Weather> items = await _dao.list();
    if (!listEquals(_weathers.value, items)) _weathers.add(items);

    return items;
  }

  Future<Weather> save(Weather model) async {
    if (model.position == Weather.POSITION_NONE) {
//      final items = await _dao.list();
//      final int nextPosition =
//          max(0, items.map((item) => item.position).reduce(max)) + 1;
    }

    await _dao.save(model);

    if (_weathers.hasValue) {
      final currentItems = _weathers.value;
      currentItems.add(model);
      _weathers.add(currentItems);
    } else {
      listSavedWeathers();
    }

    return model;
  }

  Future<List<Weather>> findWeather(String query, Country country) {
    return _apiClient.findWeather(query, country.source);
  }

  Future<void> remove(Weather model) async {
    await _dao.remove(model);
    if (_weathers.hasValue) {
      final currentItems = _weathers.value;
      currentItems.remove(model);
      _weathers.add(currentItems);
    } else {
      return listSavedWeathers();
    }
  }

  Future<String> getComment(DateTime dateTime) {
    return _apiClient.getWeatherComment(dateTime);
  }

  Future<List<Country>> listCountries() async {
    if (_countriesCache.isEmpty) {
      _countriesCache = await _apiClient.listCountries();
    }

    return _countriesCache
        .where((Country country) => country.isVisible)
        .toList();
  }

  Country getSuggestedCountry(Locale locale, List<Country> countries) {
    final supportedLanguageCodes = {
      'pl': 'pl',
      'sv': 'sv',
      'nb': 'no',
      'en': 'pl'
    };
    final languageCode = supportedLanguageCodes[locale.languageCode] ?? 'pl';

    return countries.firstWhere(
      (Country country) => country.source == languageCode,
      orElse: () => countries.first,
    );
  }
}
