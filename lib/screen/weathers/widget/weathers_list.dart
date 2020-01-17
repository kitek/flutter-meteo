import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/screen/weathers/bloc/weathers_bloc.dart';
import 'package:meteo/screen/weathers/bloc/weathers_event.dart';

class WeathersList extends StatelessWidget {
  final List<Weather> weathers;

  const WeathersList({Key key, @required this.weathers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weathers.length,
      itemBuilder: (context, index) => _buildListTile(context, weathers[index]),
    );
  }

  Widget _buildListTile(BuildContext context, Weather weather) {
    return Dismissible(
      key: Key(weather.id.toString()),
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(weather.city.name),
        subtitle: Text(weather.city.voivodeship),
      ),
      onDismissed: (direction) {
        BlocProvider.of<WeathersBloc>(context).add(DeleteWeather(weather));
      },
    );
  }
}
