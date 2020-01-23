import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/comment/bloc/comment_event.dart';
import 'package:meteo/screen/comment/bloc/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final WeatherRepository repository;
  final DateTime firstDate = DateTime(2018);

  CommentBloc({@required this.repository});

  @override
  CommentState get initialState => CommentLoading();

  DateTime get dateTime {
    final now = DateTime.now();
    if (state is CommentLoaded) {
      return (state as CommentLoaded)?.dateTime ?? now;
    }
    return now;
  }

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadComment) {
      yield* _mapLoadCommentToState(event);
    }
  }

  Stream<CommentState> _mapLoadCommentToState(LoadComment event) async* {
    yield CommentLoading();

    try {
      final commentBody = await repository.getComment(event.dateTime);
      yield CommentLoaded(body: commentBody, dateTime: event.dateTime);
    } catch (_) {
      yield CommentNotLoaded();
    }
  }
}
