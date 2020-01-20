import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/comment/bloc/comment_bloc.dart';
import 'package:meteo/screen/comment/bloc/comment_event.dart';
import 'package:meteo/screen/comment/bloc/comment_state.dart';

class CommentScreen extends StatelessWidget {
  final WeatherRepository repository;

  const CommentScreen({Key key, @required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentBloc>(
      create: (_) {
        return CommentBloc(repository: repository)
          ..add(LoadComment(dateTime: DateTime.now()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Komentarz synoptyka'),
          actions: _buildActions(),
        ),
        body: BlocBuilder<CommentBloc, CommentState>(
          builder: (BuildContext context, CommentState state) {
            if (state is CommentLoading) {
              return Align(child: CircularProgressIndicator());
            } else if (state is CommentLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.body,
                    style: TextStyle(fontSize: 16.0, height: 1.2),
                  ),
                ),
              );
            } else if (state is CommentNotLoaded) {
              return Align(child: Text('Error'));
            }

            return Text('Ka boom');
          },
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      Builder(
        builder: (BuildContext context) => IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: () async {
            final DateTime dateTime = await showDatePicker(
              context: context,
              firstDate: DateTime(2018),
              lastDate: DateTime.now(),
              initialDate: BlocProvider.of<CommentBloc>(context).dateTime,
            );

            final loadEvent = LoadComment(dateTime: dateTime);
            BlocProvider.of<CommentBloc>(context).add(loadEvent);
          },
        ),
      ),
    ];
  }
}
