import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';

class WeatherApiClient {
  static const _authority = 'meteo-app.firebaseio.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Country>> listCountries() async {
    final uri = Uri.https(_authority, 'countries.json');
    final response = await this.httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Error listing countries');
    }

    final Map<String, dynamic> jsonMap = jsonDecode(response.body);
    return jsonMap.values.map((json) => Country.fromJson(json)).toList();
  }

  Future<List<Weather>> findWeatherByGeohash({
    @required String geohash,
    @required String countrySource,
    int limit = 50,
  }) {
    final queryStart = geohash;
    final queryEnd = '$queryStart\~';

    return _findWeather(
      countrySource: countrySource,
      orderBy: 'geohash',
      startAt: queryStart,
      endAt: queryEnd,
      limit: limit,
    );
  }

  Future<List<Weather>> findWeatherByName({
    @required String queryName,
    @required String countrySource,
    int limit = 10,
  }) {
    final queryStart = removeDiacritics(queryName.toLowerCase().trim());
    if (queryStart.isEmpty) return Future.value([]);
    final queryEnd = '$queryStart\~';

    return _findWeather(
      countrySource: countrySource,
      orderBy: 'searchName',
      startAt: queryStart,
      endAt: queryEnd,
      limit: limit,
    );
  }

  Future<List<Weather>> _findWeather({
    @required String countrySource,
    @required String orderBy,
    @required String startAt,
    @required String endAt,
    int limit = 10,
  }) async {
    final queryParams = {
      'orderBy': '"$orderBy"',
      'startAt': '"$startAt"',
      'endAt': '"$endAt"',
      'limitToFirst': '$limit',
    };
    final uri = Uri.https(
      _authority,
      '/cities_$countrySource.json',
      queryParams,
    );

    final response = await this.httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Error fetching cities for: $orderBy');
    }
    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> jsonMap = jsonDecode(response.body);
    final cities =
        jsonMap.values.map((json) => Weather.fromJson(json)).toList();
    cities.sort((Weather a, Weather b) => a.city.name.compareTo(b.city.name));

    return cities;
  }

  Future<String> getWeatherComment(DateTime dateTime) async {
    final day = DateFormat('yyyy-MM-dd').format(dateTime);

    final uri = Uri.https(
      _authority,
      '/comments_pl/$day.json',
    );
    final response = await this.httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Error fetching comment for $day');
    }

    final comment = response.body.trim();
    if (comment == 'null') return '';

    return comment.substring(1, comment.length - 1);
  }
}
