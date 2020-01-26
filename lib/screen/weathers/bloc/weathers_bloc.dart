import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/weathers/bloc/weathers_event.dart';
import 'package:meteo/screen/weathers/bloc/weathers_state.dart';

class WeathersBloc extends Bloc<WeathersEvent, WeathersState> {
  final WeatherRepository _repository;
  StreamSubscription<List<Weather>> _weathersSubscription;

  WeathersBloc(this._repository);

  @override
  WeathersState get initialState => WeathersLoading();

  @override
  Stream<WeathersState> mapEventToState(WeathersEvent event) async* {
    if (event is LoadWeathers) {
      _mapLoadWeathersToState();
    } else if (event is UpdateWeathers) {
      yield* _mapUpdateWeathersToState(event);
    } else if (event is DeleteWeather) {
      yield* _mapDeleteWeatherToState(event.model);
    } else if (event is AddWeather) {
      yield* _mapAddWeatherToState(event.model);
    }
  }

  void _mapLoadWeathersToState() {
    _weathersSubscription?.cancel();
    _weathersSubscription = _repository.savedWeathers.listen((items) {
      add(UpdateWeathers(items));
    });
  }

  Stream<WeathersState> _mapDeleteWeatherToState(Weather model) async* {
    if (state is WeathersLoaded) {
      await _repository.remove(model);
    }
  }

  Stream<WeathersState> _mapAddWeatherToState(Weather model) async* {
    if (state is WeathersLoaded) {
      await _repository.save(model);
    }
  }

  @override
  Future<void> close() {
    _weathersSubscription?.cancel();
    return super.close();
  }

  Stream<WeathersState> _mapUpdateWeathersToState(UpdateWeathers event) async* {
    if (event.weathers.isEmpty) {
      yield WeathersEmpty();
    } else {
      yield WeathersLoaded(event.weathers);
    }
  }
}
