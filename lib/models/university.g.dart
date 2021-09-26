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
    json['dualDegree'] as String,
    (json['gpa'] as num).toDouble(),
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

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'country': instance.countryName,
      'city': instance.city,
      'school': instance.school,
      'dates': instance.dates,
      'language': instance.language,
      'dualDegree': instance.dualDegree,
      'gpa': instance.gpa,
      'additionalFees': instance.additionalFees,
      'places': instance.places,
      'tekfeedId': instance.tekfeedId,
      'tepitech': instance.tepitech,
      'TOEFL': instance.TOEFL,
      'IELTS': instance.IELTS,
      'TOEIC': instance.TOEIC,
      'duolingo': instance.duolingo,
      'themes': instance.themes,
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
