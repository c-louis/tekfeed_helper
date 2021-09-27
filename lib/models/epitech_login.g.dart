// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epitech_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpitechLogin _$EpitechLoginFromJson(Map<String, dynamic> json) {
  return EpitechLogin(
    json['login'] as String?,
    json['title'] as String?,
    json['internal_email'] as String?,
    json['lastname'] as String?,
    json['firstname'] as String?,
    json['promo'] as int?,
    json['semester'] as int?,
    json['location'] as String?,
    (json['gpa'] as List<dynamic>?)
        ?.map((e) => Gpa.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EpitechLoginToJson(EpitechLogin instance) =>
    <String, dynamic>{
      'login': instance.login,
      'title': instance.title,
      'internal_email': instance.internal_email,
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'promo': instance.promo,
      'semester': instance.semester,
      'location': instance.location,
      'gpa': instance.gpa,
    };

Gpa _$GpaFromJson(Map<String, dynamic> json) {
  return Gpa(
    json['gpa'] as String?,
    json['cycle'] as String?,
  );
}

Map<String, dynamic> _$GpaToJson(Gpa instance) => <String, dynamic>{
      'gpa': instance.gpa,
      'cycle': instance.cycle,
    };
