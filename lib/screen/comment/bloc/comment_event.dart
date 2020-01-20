import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadComment extends CommentEvent {
  final DateTime dateTime;

  LoadComment({DateTime dateTime}) : dateTime = dateTime ?? DateTime.now();

  @override
  List<Object> get props => [dateTime];
}
