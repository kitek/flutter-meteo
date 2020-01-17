import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/datasource/weather_api_client.dart';
import 'package:meteo/repository/datasource/weather_dao.dart';

class WeatherRepository {
  final WeatherDao _dao;
  final WeatherApiClient _apiClient;

  WeatherRepository(this._dao, this._apiClient)
      : assert(_dao != null),
        assert(_apiClient != null);

  Future<List<Weather>> listSavedWeathers() => _dao.list();

  Future<Weather> save(Weather model) async {
    if (model.position == Weather.POSITION_NONE) {
//      final items = await _dao.list();
//      final int nextPosition =
//          max(0, items.map((item) => item.position).reduce(max)) + 1;
    }

    await _dao.save(model);
    print('Model saved...');

    return model;
  }

  Future<List<Weather>> findWeather(String query, Country country) {
    return _apiClient.findWeather(query, country.source);
  }

  Future<void> remove(Weather model) {
    return _dao.remove(model);
  }

// move()

}
