import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/repository/weather_repository.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';
import 'package:meteo/screen/find/widget/country_dropdown.dart';
import 'package:meteo/screen/find/widget/search_input.dart';
import 'package:meteo/screen/find/widget/search_results_list.dart';

import 'bloc/find_bloc.dart';

class FindScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return BlocProvider(
      create: (context) => FindBloc(
        RepositoryProvider.of<WeatherRepository>(context),
      )..add(LoadCountries(locale)),
      child: BlocListener<FindBloc, FindState>(
        listener: (context, _) => Navigator.of(context).pop(),
        condition: (_, current) =>
            current is FindComplete && current.queryState is QuerySelected,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              MeteoLocalizations.of(context).chooseCity,
            ),
            actions: [
              Builder(
                builder: (BuildContext context) => IconButton(
                  icon: const Icon(Icons.gps_fixed),
                  onPressed: () =>
                      BlocProvider.of<FindBloc>(context).add(FindMe()),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 1, child: CountryDropdown()),
                    SizedBox(width: 8),
                    Expanded(flex: 2, child: SearchInput()),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(child: SearchResultList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
