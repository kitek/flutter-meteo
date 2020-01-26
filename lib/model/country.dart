import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Country extends Equatable {
  final String id;
  final String name;
  final bool isVisible;
  final String source;
  final String iconUrl;

  const Country({
    @required this.id,
    @required this.name,
    @required this.isVisible,
    @required this.source,
    @required this.iconUrl,
  })  : assert(id != null),
        assert(name != null),
        assert(isVisible != null),
        assert(source != null),
        assert(iconUrl != null);

  static Country fromJson(dynamic json) {
    return Country(
      id: json['id'],
      name: json['name'],
      isVisible: json['isVisible'],
      source: json['source'],
      iconUrl: json['iconUrl'],
    );
  }

  @override
  String toString() => 'Country { id: $id, name: $name }';

  @override
  List<Object> get props => [id, name, isVisible, source, iconUrl];
}
