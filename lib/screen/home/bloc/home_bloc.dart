import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/home/bloc/home_event.dart';
import 'package:meteo/screen/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository _repository;

  StreamSubscription<List<Weather>> _weathersSubscription;

  HomeBloc(this._repository);

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      _mapLoadToState();
    } else if (event is UpdateHome) {
      yield* _mapUpdateToState(event);
    } else if (event is RefreshHome) {
      yield* _mapRefreshToState(event);
    }
  }

  _mapLoadToState() {
    _observeSaveWeathers(false);
  }

  void _observeSaveWeathers(bool isRefresh) {
    _weathersSubscription?.cancel();
    _weathersSubscription = _repository.savedWeathers.listen((items) {
      add(UpdateHome(items, isRefresh));
    });
  }

  Stream<HomeState> _mapUpdateToState(UpdateHome event) async* {
    yield HomeLoaded(event.weathers, event.isRefresh);
  }

  Stream<HomeState> _mapRefreshToState(RefreshHome event) async* {
    yield HomeLoading();
    _observeSaveWeathers(true);
  }

  @override
  Future<void> close() {
    _weathersSubscription?.cancel();
    return super.close();
  }
}
