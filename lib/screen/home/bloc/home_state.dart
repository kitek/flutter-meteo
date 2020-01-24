import 'package:equatable/equatable.dart';
import 'package:meteo/model/weather.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Weather> weathers;

  HomeLoaded(this.weathers);

  bool get isEmpty => weathers.isEmpty;

  @override
  List<Object> get props => [weathers];

  @override
  String toString() => 'HomeLoaded { $weathers }';
}
