import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/model/city.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/weathers/bloc/weathers_bloc.dart';
import 'package:meteo/screen/weathers/bloc/weathers_event.dart';

class FindScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          WeathersBloc(RepositoryProvider.of<WeatherRepository>(context)),
      child: Scaffold(
        appBar: AppBar(title: Text(MeteoLocalizations.of(context).chooseCity)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) => Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    final model = Weather(
                      id: 82,
                      city: City(
                        name: 'Wałbrzych',
                        voivodeship: 'Dolnośląskie',
                        geohash: 'u358fscy5',
                        latitude: 50.784,
                        longitude: 16.2843,
                      ),
                      position: Weather.POSITION_NONE,
                      graphs: {
                        Weather.MODEL_UM:
                            'http://www.meteo.pl/um/metco/mgram_pict.php?ntype=0u&row=444&col=164&lang=pl',
                        Weather.MODEL_COAMPS:
                            'http://www.meteo.pl/metco/mgram_pict.php?ntype=2n&row=145&col=71&lang=pl'
                      },
                    );

                    BlocProvider.of<WeathersBloc>(context)
                        .add(AddWeather(model));
                  },
                ),
                RaisedButton(
                  child: Text('Add 2'),
                  onPressed: () {
                    final model = Weather(
                      id: 1,
                      city: City(
                        name: 'Gdańsk',
                        voivodeship: 'Pomorskie',
                        geohash: 'u358fscy5',
                        latitude: 50.784,
                        longitude: 16.2843,
                      ),
                      position: Weather.POSITION_NONE,
                      graphs: {
                        Weather.MODEL_UM:
                            'http://www.meteo.pl/um/metco/mgram_pict.php?ntype=0u&row=444&col=164&lang=pl',
                        Weather.MODEL_COAMPS:
                            'http://www.meteo.pl/metco/mgram_pict.php?ntype=2n&row=145&col=71&lang=pl'
                      },
                    );

                    BlocProvider.of<WeathersBloc>(context)
                        .add(AddWeather(model));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
