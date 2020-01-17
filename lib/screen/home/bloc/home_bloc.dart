import 'package:bloc/bloc.dart';
import 'package:meteo/screen/home/bloc/home_event.dart';
import 'package:meteo/screen/home/bloc/home_state.dart';

// Bloc<LoginEvent, LoginState> {
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeEmptyState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {}
}
