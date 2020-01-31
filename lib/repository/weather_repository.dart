import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:meteo/common/geohash/geohash.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/location.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/datasource/weather_api_client.dart';
import 'package:meteo/repository/datasource/weather_dao.dart';
import 'package:rxdart/rxdart.dart';

class WeatherRepository {
  final WeatherDao _dao;
  final WeatherApiClient _apiClient;
  final BehaviorSubject<List<Weather>> _weathers;
  final Geohash _geo = Geohash();
  final Map<String, List<Weather>> _namesCache = Map<String, List<Weather>>();
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
    // TODO calculate position
    final newModel = await _dao.save(model);

    if (_weathers.hasValue) {
      final currentItems = _weathers.value;
      if (currentItems.contains(newModel)) return newModel;

      currentItems.add(model);
      _weathers.add(currentItems);
    } else {
      listSavedWeathers();
    }

    return newModel;
  }

  Future<List<Weather>> findWeatherByName(String query, Country country) async {
    if (_namesCache.containsKey(query)) {
      return _namesCache[query];
    }

    final results = await _apiClient.findWeatherByName(
      queryName: query,
      countrySource: country.source,
    );
    _namesCache[query] = results;

    return results;
  }

  Future<List<Weather>> findWeatherByLocation({
    @required Location location,
    int limit = 50,
  }) async {
    final precision = Geohash.setPrecision(location.radius);
    final hash = _geo.encode(location.latitude, location.longitude, precision);
    final List<String> area = _geo.neighbors(hash)..add(hash);
    final countries = await listCountries();

    final requests = area
        .map((String hash) {
          return countries
              .map(
                (Country country) => findWeatherByGeohash(
                  geohash: hash,
                  countrySource: country.source,
                ),
              )
              .toList();
        })
        .expand((requestsList) => requestsList)
        .toList();

    final List<_WeatherWithDistance> models = (await Future.wait(requests))
        .expand((weathersList) => weathersList)
        .map(
          (Weather weather) => _WeatherWithDistance(
            weather: weather,
            distance: Geohash.distance(
              location,
              Location(
                latitude: weather.city.latitude,
                longitude: weather.city.longitude,
              ),
            ),
          ),
        )
        .where((model) => model.distance <= location.radius * 1.02)
        .toList();

    models.sort((a, b) {
      return (a.distance * 1000).toInt() - (b.distance * 1000).toInt();
    });

    return models
        .map((weatherWithDistance) => weatherWithDistance.weather)
        .toList();
  }

  Future<List<Weather>> findWeatherByGeohash({
    @required String geohash,
    @required String countrySource,
    int limit = 50,
  }) {
    return _apiClient.findWeatherByGeohash(
      geohash: geohash,
      countrySource: countrySource,
      limit: limit,
    );
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

class _WeatherWithDistance {
  final Weather weather;
  final double distance;

  const _WeatherWithDistance({
    @required this.weather,
    @required this.distance,
  });

  @override
  String toString() => '{ $distance, $weather }';
}
