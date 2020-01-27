import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/location.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';
import 'package:rxdart/rxdart.dart';

class FindBloc extends Bloc<FindEvent, FindState> {
  final WeatherRepository _repository;

  List<Country> _availableCountries = [];
  Country _selectedCountry;
  String _query = '';
  StreamSubscription<List<Weather>> _findOperation;

  FindBloc(this._repository);

  @override
  FindState get initialState => FindComplete();

  @override
  Stream<FindState> transformEvents(
    Stream<FindEvent> events,
    Stream<FindState> Function(FindEvent) next,
  ) {
    final nonDebounceStream = events.where((event) => event is! UpdateQuery);
    final debounceStream = events
        .where((event) => event is UpdateQuery)
        .debounce((_) => TimerStream(true, Duration(milliseconds: 500)));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<FindState> mapEventToState(FindEvent event) async* {
    if (event is LoadCountries) {
      yield* _mapLoadCountriesToState(event);
    } else if (event is SelectCountry) {
      yield* _mapSelectCountryToState(event);
    } else if (event is UpdateQuery) {
      yield* _mapUpdateQueryToState(event);
    } else if (event is UpdateResults) {
      yield* _mapUpdateResultsToState(event);
    } else if (event is SelectWeather) {
      yield* _mapSelectWeatherToState(event);
    } else if (event is FindMe) {
      yield* _mapFindMeToState(event);
    }
  }

  Stream<FindState> _mapLoadCountriesToState(LoadCountries event) async* {
    final countries = await _repository.listCountries();
    _availableCountries = countries;
    _selectedCountry = _repository.getSuggestedCountry(event.locale, countries);

    yield FindComplete(
      countriesState: CountriesLoaded(_availableCountries, _selectedCountry),
    );
  }

  Stream<FindState> _mapSelectCountryToState(SelectCountry event) async* {
    _findOperation?.cancel();
    _selectedCountry = event.country;

    yield FindComplete(
      countriesState: CountriesLoaded(_availableCountries, _selectedCountry),
    );
  }

  Stream<FindState> _mapUpdateQueryToState(UpdateQuery event) async* {
    _query = event.query;

    yield FindComplete(
      countriesState: CountriesLoaded(_availableCountries, _selectedCountry),
      suggestionsState: SuggestionsLoading(),
      query: _query,
    );

    _findOperation?.cancel();
    _findOperation = _repository
        .findWeatherByName(_query, _selectedCountry)
        .asStream()
        .listen((results) => add(UpdateResults(results, _query)));
  }

  Stream<FindState> _mapUpdateResultsToState(UpdateResults event) async* {
    yield FindComplete(
      countriesState: CountriesLoaded(_availableCountries, _selectedCountry),
      suggestionsState: SuggestionsLoaded(
        suggestedWeathers: event.results,
        query: event.query,
      ),
      query: event.query,
    );
  }

  Stream<FindState> _mapSelectWeatherToState(SelectWeather event) async* {
    final weather = event.weather;
    await _repository.save(weather);

    yield FindComplete(
      countriesState: CountriesLoaded(_availableCountries, _selectedCountry),
      suggestionsState: SuggestionSelected(),
      query: _query,
    );
  }

  @override
  Future<void> close() {
    _findOperation?.cancel();
    return super.close();
  }

  Stream<FindState> _mapFindMeToState(FindMe event) async* {
    if (state is! FindComplete) return;
    final currentState = state as FindComplete;
    yield currentState.copyWith(suggestionsState: SuggestionsLoading());

    try {
      final result = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.lowest,
      );
      final center = Location(
        latitude: result.latitude,
        longitude: result.longitude,
      );
      final weathers =
          await _repository.findWeatherByLocation(location: center);

      yield currentState.copyWith(
        suggestionsState: SuggestionsLoaded(suggestedWeathers: weathers),
        query: '',
      );
    } catch (e) {
      yield currentState.copyWith(suggestionsState: SuggestionsLoadingError());
    }
  }
}
