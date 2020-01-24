import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final String voivodeship;
  final String geohash;
  final double latitude;
  final double longitude;

  const City({
    this.name,
    this.voivodeship,
    this.geohash,
    this.latitude,
    this.longitude,
  });

  static City fromMap(Map<String, dynamic> map) => City(
        name: map['name'],
        voivodeship: map['voivodeship'],
        geohash: map['geohash'],
        latitude: map['latitude'],
        longitude: map['longitude'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'voivodeship': voivodeship,
        'geohash': geohash,
        'latitude': latitude,
        'longitude': longitude
      };

  @override
  String toString() => 'City { name: $name, voivodeship: $voivodeship }';

  @override
  List<Object> get props => [name, voivodeship, geohash, latitude, longitude];
}
