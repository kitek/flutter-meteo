import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/model/weather.dart';

abstract class FindEvent extends Equatable {
  const FindEvent();

  @override
  List<Object> get props => [];
}

class LoadCountries extends FindEvent {
  final Locale locale;

  const LoadCountries(this.locale);

  @override
  List<Object> get props => [locale];
}

class SelectCountry extends FindEvent {
  final Country country;

  const SelectCountry(this.country);

  @override
  List<Object> get props => [country];

  @override
  String toString() => 'SelectCountry { $country }';
}

class SelectWeather extends FindEvent {
  final Weather weather;

  const SelectWeather(this.weather);

  @override
  List<Object> get props => [weather];

  @override
  String toString() => 'SelectedWeather { $weather }';
}

class UpdateQuery extends FindEvent {
  final String query;

  const UpdateQuery(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'UpdateQuery { $query }';
}

class UpdateResults extends FindEvent {
  final List<Weather> results;
  final String query;

  const UpdateResults(this.results, this.query);

  @override
  List<Object> get props => [results, query];

  @override
  String toString() => 'UpdateResults { results: $results, query: $query}';
}
