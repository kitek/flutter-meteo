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
  final bool showSnackBar;

  HomeLoaded(this.weathers, this.showSnackBar);

  bool get isEmpty => weathers.isEmpty;

  @override
  List<Object> get props => [weathers, showSnackBar];

  @override
  String toString() => 'HomeLoaded { $weathers, showSnackBar: $showSnackBar }';
}
