import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MeteoLocalizations {
  final Locale locale;

  MeteoLocalizations(this.locale);

  static MeteoLocalizations of(BuildContext context) {
    return Localizations.of<MeteoLocalizations>(context, MeteoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Meteo',
      'my_cities': 'My cities',
      'comment': 'Forecaster comment',
      'legend': 'Legend',
      'choose_city': 'Choose city',
      'cities_empty': 'The list is empty. Add new city.',
      'no_graph': 'No forecast graph',
      'error_occurred': 'Error occurred :(',
      'refreshed': 'Refreshed',
    },
    'pl': {
      'app_name': 'Meteo',
      'my_cities': 'Moje miasta',
      'comment': 'Komentarz synoptyka',
      'legend': 'Legenda',
      'choose_city': 'Wybierz miasto',
      'cities_empty': 'Pusto. Dodaj nowe miasto.',
      'no_graph': 'Brak meteorogramu',
      'error_occurred': 'Wystąpił błąd :(',
      'refreshed': 'Zaktualizowano',
    },
  };

  String get appName => _localizedValues[locale.languageCode]['app_name'];

  String get myCities => _localizedValues[locale.languageCode]['my_cities'];

  String get comment => _localizedValues[locale.languageCode]['comment'];

  String get legend => _localizedValues[locale.languageCode]['legend'];

  String get chooseCity => _localizedValues[locale.languageCode]['choose_city'];

  String get noGraph => _localizedValues[locale.languageCode]['no_graph'];

  String get citiesEmpty =>
      _localizedValues[locale.languageCode]['cities_empty'];

  String get errorOccurred =>
      _localizedValues[locale.languageCode]['error_occurred'];

  String get refreshed => _localizedValues[locale.languageCode]['refreshed'];
}

class MeteoLocalizationsDelegate
    extends LocalizationsDelegate<MeteoLocalizations> {
  const MeteoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pl'].contains(locale.languageCode);

  @override
  Future<MeteoLocalizations> load(Locale locale) {
    return SynchronousFuture<MeteoLocalizations>(MeteoLocalizations(locale));
  }

  @override
  bool shouldReload(MeteoLocalizationsDelegate old) => false;
}
