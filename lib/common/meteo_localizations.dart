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
      'choose_city': 'Choose a city',
      'cities_empty': 'The list is empty. Add a new city.',
      'no_graph': 'No forecast graph',
      'error_occurred': 'Error occurred :(',
      'refreshed': 'Refreshed',
      'enter_city_name': 'Type city name',
      'city_not_found': 'City not found. Please type another name.',
      'comment_unavailable': 'Comment unavailable.\nTry again later.',
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
      'enter_city_name': 'Podaj nazwę miasta',
      'city_not_found': 'Miasto nieznalezione. Wpisz inną nazwę.',
      'comment_unavailable': 'Komentarz niedostępny.\nSpróbuj później.',
    },
    'sv': {
      'app_name': 'Meteo',
      'my_cities': 'Mina städer',
      'comment': 'Prognos kommentar',
      'legend': 'Legend',
      'choose_city': 'Välj stad',
      'cities_empty': 'Listan är tom. Lägg till en ny stad.',
      'no_graph': 'Ingen prognosgraf',
      'error_occurred': 'Fel inträffade :(',
      'refreshed': 'Uppdateras',
      'enter_city_name': 'Ange stadens namn',
      'city_not_found': 'Staden hittades inte. Skriv ett annat namn.',
      'comment_unavailable':
          'Kommentaren är inte tillgänglig.\nFörsök igen senare.',
    },
    'nb': {
      'app_name': 'Meteo',
      'my_cities': 'Byene mine',
      'comment': 'Prognosekommentar',
      'legend': 'Legende',
      'choose_city': 'Velg en by',
      'cities_empty': 'Listen er tom. Legg til en ny by.',
      'no_graph': 'Ingen prognosegraf',
      'error_occurred': 'Feil oppstod :(',
      'refreshed': 'Oppdateres',
      'enter_city_name': 'Oppgi bynavn',
      'city_not_found': 'By ikke funnet. Skriv inn et annet navn.',
      'comment_unavailable':
          'Kommentaren er ikke tilgjengelig.\nPrøv igjen senere.',
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

  String get enterCityName =>
      _localizedValues[locale.languageCode]['enter_city_name'];

  String get cityNotFound =>
      _localizedValues[locale.languageCode]['city_not_found'];

  String get commentUnavailable =>
      _localizedValues[locale.languageCode]['comment_unavailable'];
}

class MeteoLocalizationsDelegate
    extends LocalizationsDelegate<MeteoLocalizations> {
  const MeteoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pl', 'sv', 'nb'].contains(locale.languageCode);
  }

  @override
  Future<MeteoLocalizations> load(Locale locale) {
    return SynchronousFuture<MeteoLocalizations>(MeteoLocalizations(locale));
  }

  @override
  bool shouldReload(MeteoLocalizationsDelegate old) => false;
}
