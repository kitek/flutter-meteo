import 'package:equatable/equatable.dart';
import 'package:meteo/model/weather.dart';

abstract class WeathersEvent extends Equatable {
  const WeathersEvent();

  @override
  List<Object> get props => [];
}

class LoadWeathers extends WeathersEvent {}

class DeleteWeather extends WeathersEvent {
  final Weather model;

  const DeleteWeather(this.model);

  @override
  List<Object> get props => [model];

  @override
  String toString() => 'DeleteWeather { model: $model }';
}

class AddWeather extends WeathersEvent {
  final Weather model;

  const AddWeather(this.model);

  @override
  List<Object> get props => [model];

  @override
  String toString() => 'AddWeather { model: $model }';
}
