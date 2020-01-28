import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:meteo/screen/find/bloc/find_bloc.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          onChanged: (String value) {
            BlocProvider.of<FindBloc>(context).add(UpdateQuery(value));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: MeteoLocalizations.of(context).enterCityName,
          ),
        ),
        BlocBuilder<FindBloc, FindState>(
          builder: (context, state) {
            final SuggestionsState queryState = state is FindComplete
                ? state.suggestionsState
                : SuggestionsLoading();

            if (queryState is SuggestionsLoading) {
              return Positioned(
                right: 16,
                top: 19,
                child: Container(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
