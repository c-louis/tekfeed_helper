// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanghaiRankedUniversity _$ShanghaiRankedUniversityFromJson(
    Map<String, dynamic> json) {
  return ShanghaiRankedUniversity(
    json['universityName'] as String,
    json['worldRank'] as int,
    json['countryName'] as String,
  );
}

Map<String, dynamic> _$ShanghaiRankedUniversityToJson(
        ShanghaiRankedUniversity instance) =>
    <String, dynamic>{
      'universityName': instance.universityName,
      'worldRank': instance.worldRank,
      'countryName': instance.countryName,
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
