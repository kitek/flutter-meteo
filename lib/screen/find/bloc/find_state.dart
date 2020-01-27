import 'package:equatable/equatable.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';

abstract class FindState extends Equatable {
  const FindState();

  @override
  List<Object> get props => [];
}

class FindComplete extends FindState {
  final CountriesState countriesState;
  final SuggestionsState suggestionsState;
  final String query;

  const FindComplete({
    this.countriesState = const CountriesLoading(),
    this.suggestionsState = const SuggestionsLoaded(),
    this.query = '',
  });

  FindComplete copyWith({
    CountriesState countriesState,
    SuggestionsState suggestionsState,
    String query,
  }) {
    return FindComplete(
      countriesState: countriesState ?? this.countriesState,
      suggestionsState: suggestionsState ?? this.suggestionsState,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [countriesState, suggestionsState, query];

  @override
  String toString() => 'FindComplete { $suggestionsState }';
}

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountriesLoading extends CountriesState {
  const CountriesLoading();
}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;
  final Country selectedCountry;

  const CountriesLoaded(this.countries, this.selectedCountry);

  @override
  List<Object> get props => [countries, selectedCountry];
}

abstract class SuggestionsState extends Equatable {
  const SuggestionsState();

  @override
  List<Object> get props => [];
}

class SuggestionsLoading extends SuggestionsState {
  const SuggestionsLoading();
}

class SuggestionsLoaded extends SuggestionsState {
  final List<Weather> suggestedWeathers;
  final String query;

  const SuggestionsLoaded({
    this.suggestedWeathers = const [],
    this.query = '',
  });

  bool get hasEmptyResults => query.isNotEmpty && suggestedWeathers.isEmpty;

  @override
  List<Object> get props => [suggestedWeathers, query];

  @override
  String toString() => 'SuggestionsLoaded { $suggestedWeathers }';
}

class SuggestionsLoadingError extends SuggestionsState {
  const SuggestionsLoadingError();
}

class SuggestionSelected extends SuggestionsState {
  const SuggestionSelected();
}
