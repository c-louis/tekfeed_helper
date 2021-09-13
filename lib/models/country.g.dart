// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    json['name'] as String,
    (json['topLevelDomain'] as List<dynamic>).map((e) => e as String).toList(),
    json['alpha2Code'] as String,
    json['alpha3Code'] as String,
    (json['callingCodes'] as List<dynamic>).map((e) => e as String).toList(),
    json['capital'] as String,
    (json['altSpellings'] as List<dynamic>).map((e) => e as String).toList(),
    json['region'] as String,
    json['subregion'] as String,
    json['population'] as int,
    (json['latlng'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    json['demonym'] as String,
    (json['area'] as num?)?.toDouble(),
    (json['gini'] as num?)?.toDouble(),
    (json['timezones'] as List<dynamic>).map((e) => e as String).toList(),
    (json['borders'] as List<dynamic>).map((e) => e as String).toList(),
    json['nativeName'] as String,
    json['numericCode'] as String?,
    (json['currencies'] as List<dynamic>)
        .map((e) => Currency.fromJson(e))
        .toList(),
    json['flag'] as String,
    json['cioc'] as String?,
    (json['languages'] as List<dynamic>)
        .map((e) => Language.fromJson(e))
        .toList(),
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'topLevelDomain': instance.topLevelDomain,
      'alpha2Code': instance.alpha2Code,
      'alpha3Code': instance.alpha3Code,
      'callingCodes': instance.callingCodes,
      'capital': instance.capital,
      'altSpellings': instance.altSpellings,
      'region': instance.region,
      'subregion': instance.subregion,
      'population': instance.population,
      'latlng': instance.latlng,
      'demonym': instance.demonym,
      'area': instance.area,
      'gini': instance.gini,
      'timezones': instance.timezones,
      'borders': instance.borders,
      'nativeName': instance.nativeName,
      'numericCode': instance.numericCode,
      'currencies': instance.currencies,
      'languages': instance.languages,
      'flag': instance.flag,
      'cioc': instance.cioc,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    json['code'] as String?,
    json['name'] as String?,
    json['symbol'] as String?,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return Language(
    json['iso639_1'] as String?,
    json['iso639_2'] as String?,
    json['name'] as String?,
    json['nativeName'] as String?,
  );
}

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'iso639_1': instance.iso639_1,
      'iso639_2': instance.iso639_2,
      'name': instance.name,
      'nativeName': instance.nativeName,
    };
