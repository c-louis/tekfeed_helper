// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    region: json['region'] as String?,
    language: json['language'] as String?,
    selectedCountries: (json['selectedCountries'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    selectedThemes: (json['selectedThemes'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    shanghaiRankedOnly: json['shanghaiRankedOnly'] as bool,
    icuRankedOnly: json['icuRankedOnly'] as bool,
    noAdditionalFees: json['noAdditionalFees'] as bool,
    feesLimit: json['feesLimit'] as bool,
    feesMax: (json['feesMax'] as num).toDouble(),
    noGpaRequired: json['noGpaRequired'] as bool,
    gpaRequiredLimit: json['gpaRequiredLimit'] as bool,
    gpaRequiredMax: (json['gpaRequiredMax'] as num).toDouble(),
    tepitechRequiredLimit: json['tepitechRequiredLimit'] as bool,
    TOEFLRequiredLimit: json['TOEFLRequiredLimit'] as bool,
    IELTSRequiredLimit: json['IELTSRequiredLimit'] as bool,
    TOEICRequiredLimit: json['TOEICRequiredLimit'] as bool,
    duolingoRequiredLimit: json['duolingoRequiredLimit'] as bool,
    tepitechRequiredMax: (json['tepitechRequiredMax'] as num).toDouble(),
    TOEFLRequiredMax: (json['TOEFLRequiredMax'] as num).toDouble(),
    IELTSRequiredMax: (json['IELTSRequiredMax'] as num).toDouble(),
    TOEICRequiredMax: (json['TOEICRequiredMax'] as num).toDouble(),
    duolingoRequiredMax: (json['duolingoRequiredMax'] as num).toDouble(),
    shanghaiRankedSort: json['shanghaiRankedSort'] as bool,
    icuRankedSort: json['icuRankedSort'] as bool,
    costOfLivingSort: json['costOfLivingSort'] as bool,
    rentCostSort: json['rentCostSort'] as bool,
    groceriesCostSort: json['groceriesCostSort'] as bool,
    restaurantCostSort: json['restaurantCostSort'] as bool,
    shanghaiRankedSortValue:
        (json['shanghaiRankedSortValue'] as num).toDouble(),
    icuRankedSortValue: (json['icuRankedSortValue'] as num).toDouble(),
    costOfLivingSortValue: (json['costOfLivingSortValue'] as num).toDouble(),
    rentCostSortValue: (json['rentCostSortValue'] as num).toDouble(),
    groceriesCostSortValue: (json['groceriesCostSortValue'] as num).toDouble(),
    restaurantCostSortValue:
        (json['restaurantCostSortValue'] as num).toDouble(),
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'language': instance.language,
      'selectedCountries': instance.selectedCountries,
      'selectedThemes': instance.selectedThemes,
      'shanghaiRankedOnly': instance.shanghaiRankedOnly,
      'icuRankedOnly': instance.icuRankedOnly,
      'noAdditionalFees': instance.noAdditionalFees,
      'feesLimit': instance.feesLimit,
      'feesMax': instance.feesMax,
      'noGpaRequired': instance.noGpaRequired,
      'gpaRequiredLimit': instance.gpaRequiredLimit,
      'gpaRequiredMax': instance.gpaRequiredMax,
      'tepitechRequiredLimit': instance.tepitechRequiredLimit,
      'TOEFLRequiredLimit': instance.TOEFLRequiredLimit,
      'IELTSRequiredLimit': instance.IELTSRequiredLimit,
      'TOEICRequiredLimit': instance.TOEICRequiredLimit,
      'duolingoRequiredLimit': instance.duolingoRequiredLimit,
      'tepitechRequiredMax': instance.tepitechRequiredMax,
      'TOEFLRequiredMax': instance.TOEFLRequiredMax,
      'IELTSRequiredMax': instance.IELTSRequiredMax,
      'TOEICRequiredMax': instance.TOEICRequiredMax,
      'duolingoRequiredMax': instance.duolingoRequiredMax,
      'shanghaiRankedSort': instance.shanghaiRankedSort,
      'icuRankedSort': instance.icuRankedSort,
      'costOfLivingSort': instance.costOfLivingSort,
      'rentCostSort': instance.rentCostSort,
      'groceriesCostSort': instance.groceriesCostSort,
      'restaurantCostSort': instance.restaurantCostSort,
      'shanghaiRankedSortValue': instance.shanghaiRankedSortValue,
      'icuRankedSortValue': instance.icuRankedSortValue,
      'costOfLivingSortValue': instance.costOfLivingSortValue,
      'rentCostSortValue': instance.rentCostSortValue,
      'groceriesCostSortValue': instance.groceriesCostSortValue,
      'restaurantCostSortValue': instance.restaurantCostSortValue,
    };
