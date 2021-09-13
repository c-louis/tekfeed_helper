import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

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
  final String flag;
  final String? cioc;
  @JsonKey(ignore: true) CostOfLiving? costOfLiving;

  Country(this.name, this.topLevelDomain, this.alpha2Code, this.alpha3Code, this.callingCodes, this.capital, this.altSpellings, this.region, this.subregion, this.population, this.latlng, this.demonym, this.area, this.gini, this.timezones, this.borders, this.nativeName, this.numericCode, this.currencies, this.flag, this.cioc);
  factory Country.fromJson(json) => _$CountryFromJson(json);
  factory Country.empty() => Country('UNKNOWN', [], '', '', [], '', [], '', '', 0, [], '', 0.0, 0.0, [], [], '', '', [], '', '');

  static Future<List<Country>> load() async {
    List<Country> countries = [];
    var url = Uri.parse('https://restcountries.eu/rest/v2/all');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      for (var item in list) {
        countries.add(Country.fromJson(item));
      }
    }
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
  final String iso639_1;
  final String iso639_2;
  final String name;
  final String nativeName;

  Language(this.iso639_1, this.iso639_2, this.name, this.nativeName);
  factory Language.fromJson(json) => _$LanguageFromJson(json);
}

@JsonSerializable()
class CostOfLiving {
  @JsonKey(name: 'country') final String countryName;
  final double costOfLivingIndex;
  final double rentIndex;
  final double costOfLivingPlusRentIndex;
  final double groceriesIndex;
  final double restaurantPriceIndex;
  final double localPurchasingPowerIndex;

  CostOfLiving(this.countryName, this.costOfLivingIndex, this.rentIndex, this.costOfLivingPlusRentIndex, this.groceriesIndex, this.restaurantPriceIndex, this.localPurchasingPowerIndex,);
  factory CostOfLiving.fromJson(json) => _$CostOfLivingFromJson(json);

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