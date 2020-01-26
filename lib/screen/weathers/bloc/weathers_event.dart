import 'package:equatable/equatable.dart';
import 'package:meteo/model/weather.dart';

abstract class WeathersEvent extends Equatable {
  const WeathersEvent();

  @override
  List<Object> get props => [];
}

class LoadWeathers extends WeathersEvent {}

class UpdateWeathers extends WeathersEvent {
  final List<Weather> weathers;

  const UpdateWeathers(this.weathers);

  @override
  List<Object> get props => [weathers];

  @override
  String toString() => 'UpdateWeathers { $weathers }';
}

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
