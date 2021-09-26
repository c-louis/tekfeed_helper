import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
class Theme {
  final String name;

  Theme({required this.name});

  factory Theme.fromJson(json) => _$ThemeFromJson(json);
}