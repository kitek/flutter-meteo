import 'package:meta/meta.dart';

class Location {
  final double latitude;
  final double longitude;
  final double radius;

  const Location({
    @required this.latitude,
    @required this.longitude,
    this.radius = 25.0,
  });
}
