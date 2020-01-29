import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo/model/country.dart';
import 'package:meteo/screen/find/bloc/find_bloc.dart';
import 'package:meteo/screen/find/bloc/find_event.dart';
import 'package:meteo/screen/find/bloc/find_state.dart';

class CountryDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: BlocBuilder<FindBloc, FindState>(
          builder: (context, state) {
            final CountriesState countriesState = (state is FindComplete)
                ? state.countriesState
                : CountriesLoading();

            if (countriesState is CountriesLoading) {
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              );
            } else if (countriesState is CountriesLoaded) {
              return DropdownButton<Country>(
                value: countriesState.selectedCountry,
                items: _buildDropdownItems(countriesState.countries),
                onChanged: (Country country) {
                  BlocProvider.of<FindBloc>(context)
                      .add(SelectCountry(country));
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<Country>> _buildDropdownItems(List<Country> countries) {
    return countries.map((Country country) {
      return DropdownMenuItem<Country>(
        value: country,
        child: Text(country.name),
      );
    }).toList();
  }
}
