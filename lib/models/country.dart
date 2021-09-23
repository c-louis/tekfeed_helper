import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'country.g.dart';

@JsonSerializable()
class Country {
  final String name;
  final List<String> topLevelDomain;
  final String alpha2Code;
  final String alpha3Code;
  final List<String> callingCodes;
  final String capital;
  final List<String> altSpellings;
  final String region;
  final String subregion;
  final int population;
  final List<double> latlng;
  final String demonym;
  final double? area;
  final double? gini;
  final List<String> timezones;
  final List<String> borders;
  final String nativeName;
  final String? numericCode;
  final List<Currency> currencies;
  final List<Language> languages;
  final String flag;
  final String? cioc;
  @JsonKey(ignore: true) CostOfLiving? costOfLiving;

  Country(this.name, this.topLevelDomain, this.alpha2Code, this.alpha3Code, this.callingCodes, this.capital, this.altSpellings, this.region, this.subregion, this.population, this.latlng, this.demonym, this.area, this.gini, this.timezones, this.borders, this.nativeName, this.numericCode, this.currencies, this.flag, this.cioc, this.languages);
  factory Country.fromJson(json) => _$CountryFromJson(json);
  factory Country.empty() => Country('UNKNOWN', [], '', '', [], '', [], '', '', 0, [], '', 0.0, 0.0, [], [], '', '', [], '', '', []);

  static Future<List<Country>> load() async {
    List<Country> countries = [];
//    var url = Uri.parse('https://restcountries.com/v3/all');
//    var response = await http.get(url);
//    if (response.statusCode == 200) {
      String fileContent = await rootBundle.loadString('assets/data/country.json');
      var list = jsonDecode(fileContent);
      for (var item in list) {
        countries.add(Country.fromJson(item));
      }
//    }
    return Future.value(countries);
  }
}

@JsonSerializable()
class Currency {
  final String? code;
  final String? name;
  final String? symbol;

  Currency(this.code, this.name, this.symbol);
  factory Currency.fromJson(json) => _$CurrencyFromJson(json);
}

@JsonSerializable()
class Language {
  final String? iso639_1;
  final String? iso639_2;
  final String? name;
  final String? nativeName;

  Language(this.iso639_1, this.iso639_2, this.name, this.nativeName);
  factory Language.fromJson(json) => _$LanguageFromJson(json);
}

class CostOfLiving {
  @JsonKey(name: 'country') final String countryName;
  double costOfLivingIndex;
  double rentIndex;
  double costOfLivingPlusRentIndex;
  double groceriesIndex;
  double restaurantPriceIndex;
  double localPurchasingPowerIndex;

  CostOfLiving(this.countryName, this.costOfLivingIndex, this.rentIndex, this.costOfLivingPlusRentIndex, this.groceriesIndex, this.restaurantPriceIndex, this.localPurchasingPowerIndex,);
  factory CostOfLiving.fromJson(json) {
    return CostOfLiving(
      json['country'] as String,
      double.parse(json['costOfLivingIndex'] as String),
      double.parse(json['rentIndex'] as String),
      double.parse(json['costOfLivingPlusRentIndex'] as String),
      double.parse(json['groceriesIndex'] as String),
      double.parse(json['restaurantPriceIndex'] as String),
      double.parse(json['localPurchasingPowerIndex'] as String),
    );
  }

  static Future<List<CostOfLiving>> load() async {
    List<CostOfLiving> col = [];
    var url = Uri.parse('http://tekfeed-middle-api.cl-dev.ovh/col');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      for (var item in list) {
        col.add(CostOfLiving.fromJson(item));
      }
    }
    return Future.value(col);

  }
}