import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/screen/find/bloc/find_bloc.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';

class SearchResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindBloc, FindState>(
      builder: (context, state) {
        final QueryState queryState =
            (state is FindComplete) ? state.queryState : QueryLoaded();

        if (queryState is QueryLoaded) {
          if (queryState.hasEmptyResults) {
            return Align(
              child: Text(MeteoLocalizations.of(context).cityNotFound),
            );
          } else {
            return ListView.builder(
              itemCount: queryState.suggestedWeathers.length,
              itemBuilder: (context, index) {
                final weather = queryState.suggestedWeathers[index];
                return ListTile(
                  title: Text(weather.city.name),
                  subtitle: Text(weather.city.voivodeship),
                  onTap: () => BlocProvider.of<FindBloc>(context)
                      .add(SelectWeather(weather)),
                );
              },
            );
          }
        }

        return Container();
      },
    );
  }
}
