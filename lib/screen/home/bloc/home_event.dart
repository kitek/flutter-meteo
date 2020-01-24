import 'package:equatable/equatable.dart';
import 'package:meteo/model/weather.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHome extends HomeEvent {}

class RefreshHome extends HomeEvent {}

class UpdateHome extends HomeEvent {
  final List<Weather> weathers;

  const UpdateHome(this.weathers);

  @override
  List<Object> get props => [weathers];
}
