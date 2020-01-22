import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentNotLoaded extends CommentState {}

class CommentLoaded extends CommentState {
  final String body;
  final DateTime dateTime;

  const CommentLoaded({@required this.body, @required this.dateTime})
      : assert(body != null),
        assert(dateTime != null);

  @override
  List<Object> get props => [body, dateTime];
}
