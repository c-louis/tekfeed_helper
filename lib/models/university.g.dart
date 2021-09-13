// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

University _$UniversityFromJson(Map<String, dynamic> json) {
  return University(
    json['country'] as String,
    json['city'] as String,
    json['school'] as String,
    json['dates'] as String,
    json['language'] as String,
    json['dualDegree'] == 'TRUE' ? true : false,
    (double.parse(json['gpa'] as String)),
    json['languageRequired'] == 'TRUE' ? true : false,
    (json['additionalFees'] as num).toDouble(),
    json['places'] as int,
    json['tekfeedId'] as int,
  )
    ..shanghaiRank = json['shanghai_ranking'] == null
        ? null
        : ShanghaiRankedUniversity.fromJson(json['shanghai_ranking'])
    ..icuRank = json['icu_ranking'] == null
        ? null
        : IcuRanking.fromJson(json['icu_ranking']);
}

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'country': instance.countryName,
      'city': instance.city,
      'school': instance.school,
      'dates': instance.dates,
      'language': instance.language,
      'dualDegree': instance.dualDegree,
      'gpa': instance.gpa,
      'languageRequired': instance.languageRequired,
      'additionalFees': instance.additionalFees,
      'places': instance.places,
      'tekfeedId': instance.tekfeedId,
      'shanghai_ranking': instance.shanghaiRank,
      'icu_ranking': instance.icuRank,
    };

ShanghaiRankedUniversity _$ShanghaiRankedUniversityFromJson(
    Map<String, dynamic> json) {
  return ShanghaiRankedUniversity(
    json['world_rank'] as int,
  );
}

Map<String, dynamic> _$ShanghaiRankedUniversityToJson(
        ShanghaiRankedUniversity instance) =>
    <String, dynamic>{
      'world_rank': instance.worldRank,
    };

IcuRanking _$IcuRankingFromJson(Map<String, dynamic> json) {
  return IcuRanking(
    json['world_rank'] as int,
    json['national_rank'] as int,
  );
}

Map<String, dynamic> _$IcuRankingToJson(IcuRanking instance) =>
    <String, dynamic>{
      'world_rank': instance.worldRank,
      'national_rank': instance.nationalRank,
    };
