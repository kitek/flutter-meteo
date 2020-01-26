// WeathersEmpty
// WeathersLoaded
// WeathersLoading

import 'package:equatable/equatable.dart';
import 'package:meteo/model/weather.dart';

abstract class WeathersState extends Equatable {
  const WeathersState();

  @override
  List<Object> get props => [];
}

class WeathersLoading extends WeathersState {}

class WeathersEmpty extends WeathersState {}

class WeathersLoaded extends WeathersState {
  final List<Weather> weathers;

  const WeathersLoaded(this.weathers);

  @override
  List<Object> get props => [weathers];

  @override
  String toString() => 'WeathersLoaded { $weathers }';
}
