import 'package:bloc/bloc.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';

class FindBloc extends Bloc<FindEvent, FindState> {
  @override
  FindState get initialState => null;

  @override
  Stream<FindState> mapEventToState(FindEvent event) {
    return null;
  }
}
