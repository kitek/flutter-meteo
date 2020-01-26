import 'package:equatable/equatable.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';

abstract class FindState extends Equatable {
  const FindState();

  @override
  List<Object> get props => [];
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

abstract class QueryState extends Equatable {
  const QueryState();

  @override
  List<Object> get props => [];
}

class QueryLoading extends QueryState {
  const QueryLoading();
}

class QueryLoaded extends QueryState {
  final List<Weather> suggestedWeathers;
  final String query;

  const QueryLoaded({
    this.suggestedWeathers = const [],
    this.query = '',
  });

  bool get hasEmptyResults => query.isNotEmpty && suggestedWeathers.isEmpty;

  @override
  List<Object> get props => [suggestedWeathers, query];
}

class QuerySelected extends QueryState {
  const QuerySelected();
}

class FindComplete extends FindState {
  final CountriesState countriesState;
  final QueryState queryState;
  final String query;

  const FindComplete({
    this.countriesState = const CountriesLoading(),
    this.queryState = const QueryLoaded(),
    this.query = '',
  });

  @override
  List<Object> get props => [countriesState, queryState, query];
}
