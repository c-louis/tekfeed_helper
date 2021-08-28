// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanghaiRankedUniversity _$ShanghaiRankedUniversityFromJson(
    Map<String, dynamic> json) {
  return ShanghaiRankedUniversity(
    json['university_name'] as String,
    json['national_rank'] as String,
    json['iso2_code'] as String?,
    json['iso3_code'] as String?,
    json['world_rank'] as String,
    (json['total_score'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ShanghaiRankedUniversityToJson(
        ShanghaiRankedUniversity instance) =>
    <String, dynamic>{
      'university_name': instance.university_name,
      'national_rank': instance.national_rank,
      'iso2_code': instance.iso2_code,
      'iso3_code': instance.iso3_code,
      'world_rank': instance.world_rank,
      'total_score': instance.total_score,
    };

IcuRanking _$IcuRankingFromJson(Map<String, dynamic> json) {
  return IcuRanking(
    json['worldRank'] as int,
    json['nationalRank'] as int,
  );
}

Map<String, dynamic> _$IcuRankingToJson(IcuRanking instance) =>
    <String, dynamic>{
      'worldRank': instance.worldRank,
      'nationalRank': instance.nationalRank,
    };
