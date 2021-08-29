import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekfeed_helper/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';

part 'university.g.dart';

class University {
  final String countryName;
  final String city;
  final String school;
  final String dates;
  final String language;
  final bool dualDegree;
  final double gpa;
  final bool languageRequired;
  final double additionalFees;
  final int places;
  @JsonKey(ignore: true) Country? country;
  @JsonKey(ignore: true) ShanghaiRankedUniversity? shanghaiRank;
  @JsonKey(ignore: true) IcuRanking? icuRank;

  University(this.countryName, this.city, this.school, this.dates, this.language,
    this.dualDegree, this.gpa, this.languageRequired, this.additionalFees,
    this.places
  );

  static Future<List<University>> loadFromAssets() async {
    List<University> unis = [];
    String csvContent = await rootBundle.loadString('assets/data/university.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(eol: '\n').convert(csvContent);

    for (int i = 1; i < rowsAsListOfValues.length; i++) {
      unis.add(University(
        rowsAsListOfValues[i][0],
        rowsAsListOfValues[i][1],
        rowsAsListOfValues[i][2],
        rowsAsListOfValues[i][3],
        rowsAsListOfValues[i][4],
        rowsAsListOfValues[i][5] == 'FALSE' ? false : true,
        double.parse(rowsAsListOfValues[i][6].toString()),
        rowsAsListOfValues[i][7] == 'FALSE' ? false : true,
        double.parse(rowsAsListOfValues[i][8].toString()),
        int.parse(rowsAsListOfValues[i][9].toString()),
      ));
    }
    return Future.value(unis);
  }
}

@JsonSerializable()
class ShanghaiRankedUniversity {
  final String universityName;
  final int worldRank;
  final String countryName;

  ShanghaiRankedUniversity(this.universityName, this.worldRank, this.countryName);
  factory ShanghaiRankedUniversity.fromJson(json) => _$ShanghaiRankedUniversityFromJson(json);
  factory ShanghaiRankedUniversity.empty() => ShanghaiRankedUniversity('UNKNOWN', 0, '');
  Map<String, dynamic> toJson() => _$ShanghaiRankedUniversityToJson(this);

  static Future<List<ShanghaiRankedUniversity>> loadFromAssets() async {
    List<ShanghaiRankedUniversity> ranks = [];
    String csvContent = await rootBundle.loadString('assets/data/shanghai.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(eol: '\n').convert(csvContent);

    for (int i = 1; i < rowsAsListOfValues.length; i++) {
      ranks.add(ShanghaiRankedUniversity(
        (rowsAsListOfValues[i][1] as String).trim(),
        rowsAsListOfValues[i][0],
        (rowsAsListOfValues[i][2] as String).trim()
      ));
    }
    return ranks;
  }

  Future<void> save(University uni) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uni.${uni.school}.rank.shanghai', jsonEncode(this.toJson()));
  }

  static Future<ShanghaiRankedUniversity?> fromPrefs(University uni) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('uni.${uni.school}.rank.icu') != null) {
      return ShanghaiRankedUniversity.fromJson(jsonDecode(prefs.getString('uni.${uni.school}.rank.shanghai')!));
    }
    return null;
  }
}

@JsonSerializable()
class IcuRanking {
  final int worldRank;
  final int nationalRank;

  IcuRanking(this.worldRank, this.nationalRank);
  Map<String, dynamic> toJson() => _$IcuRankingToJson(this);
  factory IcuRanking.fromJson(json) => _$IcuRankingFromJson(json);

  static Future<IcuRanking> fromScrapWithUni(University uni) async {
    var apiKey = 'tekfeedMiddleApiKey';
    var urlSource = 'http://tekfeed-middle-api.cl-dev.ovh/search';
    var uniSearch = uni.school.replaceAll(' ', '+');
    var url = Uri.parse('$urlSource?key=$apiKey&q=$uniSearch');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    try {
      var rankLink = json['items'][0]['link'];
      Uri uriRank = Uri.parse(rankLink);
      if (uriRank.path.indexOf('reviews') != -1) {
        WebScraper uniScrapper = WebScraper('http://tekfeed-proxy.cl-dev.ovh');
        if (await uniScrapper.loadWebPage('proxy.php?url=' + uriRank.origin + uriRank.path + '&mode=native')) {
          var elements = uniScrapper.getElement('table.text-right > tbody > tr', []);
          var countryRank = elements[0]['title'].toString().substring(15, elements[0]['title'].toString().length);
          var worldRank = elements[1]['title'].toString().substring(13, elements[1]['title'].toString().length);
          try {
            return Future.value(IcuRanking(
              int.parse(worldRank.toString()),
              int.parse(countryRank.toString())
            ));
          } catch (e) {
          }
        }
      }
    } catch (e) {
    }

    return Future.value(IcuRanking(
      -1,
      -1
    ));
  }

  Future<void> save(University uni) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uni.${uni.school}.rank.icu', jsonEncode(this.toJson()));
  }

  static Future<IcuRanking?> fromPrefs(University uni) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('uni.${uni.school}.rank.icu') != null) {
      return IcuRanking.fromJson(jsonDecode(prefs.getString('uni.${uni.school}.rank.icu')!));
    }
    return null;
  }
}