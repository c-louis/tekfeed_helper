import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:web_scraper/web_scraper.dart';

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
  factory Country.empty() => Country(
    'UNKNOWN', [], '', '', [], '', [], '', '', 0, [], '', 0.0, 0.0, [], [],
    '', '', [], '', '',
  );

  static Future<List<Country>> loadFromApi() async {
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

class CostOfLiving {
  // /cost-of-living/rankings_by_country.jsp
  final double costOfLivingIndex;
  final double rentIndex;
  final double costOfLivingPlusRentIndex;
  final double groceriesIndex;
  final double restaurantPriceIndex;
  final double localPurchasingPowerIndex;

  CostOfLiving(this.costOfLivingIndex, this.rentIndex, this.costOfLivingPlusRentIndex,
    this.groceriesIndex, this.restaurantPriceIndex, this.localPurchasingPowerIndex
  );

  static Future<Map<String, CostOfLiving>> scrapFromWeb() async {
    Map<String, CostOfLiving> costOfLivings = {};

    final webScraper = WebScraper('https://www.numbeo.com');
    if (await webScraper.loadWebPage('/cost-of-living/rankings_by_country.jsp')) {
      List<Map<String, dynamic>> elements = webScraper.getElement('table#t2 > tbody > tr > td', ['title']);

      for (int i = 0; i < elements.length; i += 8) {
        costOfLivings[elements[i + 1]['title']] = CostOfLiving(
          double.parse(elements[i + 2]['title']),
          double.parse(elements[i + 3]['title']),
          double.parse(elements[i + 4]['title']),
          double.parse(elements[i + 5]['title']),
          double.parse(elements[i + 6]['title']),
          double.parse(elements[i + 7]['title']),
        );
      }
    }

    return costOfLivings;
  }
}