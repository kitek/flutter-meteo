import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
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
          title: Text(MeteoLocalizations.of(context).comment),
          actions: _buildActions(),
        ),
        body: BlocBuilder<CommentBloc, CommentState>(
          builder: (BuildContext context, CommentState state) {
            if (state is CommentLoading) {
              return const Align(child: CircularProgressIndicator());
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
            } else {
              return Align(
                  child: Text(MeteoLocalizations.of(context).errorOccurred));
            }
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
              firstDate: BlocProvider.of<CommentBloc>(context).firstDate,
              lastDate: DateTime.now(),
              initialDate: BlocProvider.of<CommentBloc>(context).dateTime,
            );
            if (null == dateTime) return;

            final loadEvent = LoadComment(dateTime: dateTime);
            BlocProvider.of<CommentBloc>(context).add(loadEvent);
          },
        ),
      ),
    ];
  }
}
