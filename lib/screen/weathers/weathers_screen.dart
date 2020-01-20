import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/screen/app_routes.dart';
import 'package:meteo/screen/weathers/bloc/weathers_bloc.dart';
import 'package:meteo/screen/weathers/bloc/weathers_state.dart';
import 'package:meteo/screen/weathers/widget/weathers_list.dart';
import 'package:meteo/screen/weathers/widget/weathers_list_empty.dart';
import 'package:meteo/screen/weathers/widget/weathers_progress.dart';

class WeathersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Moje miasta')),
      body: BlocBuilder<WeathersBloc, WeathersState>(
        builder: (context, state) {
          if (state is WeathersLoading) {
            return WeathersProgress();
          } else if (state is WeathersLoaded) {
            return state.isEmpty
                ? WeathersListEmpty()
                : WeathersList(weathers: state.weathers);
          }

          return Text('State not supported');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.FIND),
      ),
    );
  }
}
