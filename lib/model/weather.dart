import 'package:equatable/equatable.dart';
import 'package:meteo/model/city.dart';

class Weather extends Equatable {
  final int id;
  final City city;
  final Map<String, String> graphs;
  final int position;

  static const int POSITION_NONE = -1;
  static const String MODEL_UM = 'um';
  static const String MODEL_COAMPS = 'coamps';

  const Weather({
    this.id,
    this.city,
    this.graphs,
    this.position,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final rawModels = (json['models'] as Map<String, dynamic>);
    final Map<String, String> models = rawModels.map((k, v) {
      return MapEntry<String, String>(k, v['graphUrl']);
    });

    return Weather(
      id: json['id'],
      city: City.fromMap(json),
      graphs: models,
      position: POSITION_NONE,
    );
  }

  static Weather fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'],
      city: City.fromMap(map),
      graphs: {
        MODEL_UM: map[MODEL_UM],
        MODEL_COAMPS: map[MODEL_COAMPS],
      },
      position: map['position'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'position': position,
        MODEL_UM: graphs[MODEL_UM],
        MODEL_COAMPS: graphs[MODEL_COAMPS],
      }..addAll(city.toMap());

  @override
  String toString() =>
      'Weather { id: $id, name: $city, position: $position }';

  @override
  List<Object> get props => [id, city, graphs, position];
}
