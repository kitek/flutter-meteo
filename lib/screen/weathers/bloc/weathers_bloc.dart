import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/weathers/bloc/weathers_event.dart';
import 'package:meteo/screen/weathers/bloc/weathers_state.dart';

class WeathersBloc extends Bloc<WeathersEvent, WeathersState> {
  final WeatherRepository repository;

  WeathersBloc({@required this.repository});

  @override
  WeathersState get initialState => WeathersLoading();

  @override
  Stream<WeathersState> mapEventToState(WeathersEvent event) async* {
    if (event is LoadWeathers) {
      yield* _mapLoadWeathersToState();
    } else if (event is DeleteWeather) {
      yield* _mapDeleteWeatherToState(event.model);
    } else if (event is AddWeather) {
      yield* _mapAddWeatherToState(event.model);
    }
  }

  Stream<WeathersState> _mapLoadWeathersToState() async* {
    try {
      final savedWeathers = await repository.listSavedWeathers();
      yield WeathersLoaded(savedWeathers);
    } catch (_) {
      yield WeathersNotLoaded();
    }
  }

  Stream<WeathersState> _mapDeleteWeatherToState(Weather model) async* {
    if (state is WeathersLoaded) {
      await repository.remove(model);
      yield* _mapLoadWeathersToState();
    }
  }

  Stream<WeathersState> _mapAddWeatherToState(Weather model) async* {
    if (state is WeathersLoaded) {
      await repository.save(model);
      yield* _mapLoadWeathersToState();
    }
  }
}
