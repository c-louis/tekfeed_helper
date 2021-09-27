import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekfeed_helper/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:tekfeed_helper/models/theme.dart';

part 'university.g.dart';

@JsonSerializable()
class University {
  @JsonKey(name: 'country') final String countryName;
  final String city;
  final String school;
  final String dates;
  final String language;
  final String dualDegree;
  final double gpa;
  final double additionalFees;
  final int places;
  final int tekfeedId;
  final String tepitech;
  final String TOEFL;
  final String IELTS;
  final String TOEIC;
  final String duolingo;
  final List<Theme> themes;
  @JsonKey(name: 'shanghai_ranking') ShanghaiRankedUniversity? shanghaiRank;
  @JsonKey(name: 'icu_ranking') IcuRanking? icuRank;
  @JsonKey(ignore: true) Country? country;

  University(this.countryName, this.city, this.school, this.dates, this.language, this.dualDegree, this.gpa, this.additionalFees, this.places, this.tekfeedId, this.themes, this.tepitech, this.TOEFL, this.IELTS, this.TOEIC, this.duolingo);
  factory University.fromJson(json) {
    return University(
      json['country'] as String,
      json['city'] as String,
      json['school'] as String,
      json['dates'] as String,
      json['language'] as String,
      ((json['dualDegree'] as String?) ?? ""),
      (double.parse(json['gpa'] as String)),
      (json['additionalFees'] as num).toDouble(),
      json['places'] as int,
      json['tekfeedId'] as int,
      (json['themes'] as List<dynamic>).map((e) => Theme.fromJson(e)).toList(),
      json['tepitech'] as String,
      json['TOEFL'] as String,
      json['IELTS'] as String,
      json['TOEIC'] as String,
      json['duolingo'] as String,
    )
      ..shanghaiRank = json['shanghai_ranking'] == null
          ? null
          : ShanghaiRankedUniversity.fromJson(json['shanghai_ranking'])
      ..icuRank = json['icu_ranking'] == null
          ? null
          : IcuRanking.fromJson(json['icu_ranking']);
  }
  Map<String, dynamic> toJson() => _$UniversityToJson(this);

  static Future<List<University>> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('unis-cache') != null) {
      return jsonDecode(prefs.getString('unis-cache')!);
    } else {
      var url = Uri.parse('https://tekfeed-middle-api.cl-dev.ovh/universities?all=1');
      var response = await http.get(url);
      var list = jsonDecode(response.body);
      List<University> unis = [];
      for (var item in list) {
        unis.add(University.fromJson(item));
      }
      return unis;
    }
  }
}

@JsonSerializable()
class ShanghaiRankedUniversity {
  @JsonKey(name: 'world_rank') final int worldRank;

  ShanghaiRankedUniversity(this.worldRank);
  factory ShanghaiRankedUniversity.fromJson(json) => _$ShanghaiRankedUniversityFromJson(json);
  Map<String, dynamic> toJson() => _$ShanghaiRankedUniversityToJson(this);
}

@JsonSerializable()
class IcuRanking {
  @JsonKey(name: 'world_rank') final int worldRank;
  @JsonKey(name: 'national_rank') final int nationalRank;

  IcuRanking(this.worldRank, this.nationalRank);
  Map<String, dynamic> toJson() => _$IcuRankingToJson(this);
  factory IcuRanking.fromJson(json) => _$IcuRankingFromJson(json);
}