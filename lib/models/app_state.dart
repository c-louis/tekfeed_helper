import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tekfeed_helper/helpers/university_filter.dart';
import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/helpers/university_sorter.dart';
import 'package:tekfeed_helper/models/university.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState extends ChangeNotifier {
  AppState({this.region, this.language, List<String>? selectedCountries, List<String>? selectedThemes,
    this.shanghaiRankedOnly = false, this.icuRankedOnly = false, this.noAdditionalFees = false, this.feesLimit = false,
    this.feesMax = 0, this.noGpaRequired = false, this.gpaRequiredLimit = false, this.gpaRequiredMax = 0, this.tepitechRequiredLimit = false,
    this.TOEFLRequiredLimit = false, this.IELTSRequiredLimit = false, this.TOEICRequiredLimit = false, this.duolingoRequiredLimit = false,
    this.tepitechRequiredMax = 0, this.TOEFLRequiredMax = 0, this.IELTSRequiredMax = 0, this.TOEICRequiredMax = 0, this.duolingoRequiredMax = 0,
    this.shanghaiRankedSort = false, this.icuRankedSort = false, this.costOfLivingSort = false, this.rentCostSort = false, this.groceriesCostSort = false,
    this.restaurantCostSort = false, this.shanghaiRankedSortValue = 0, this.icuRankedSortValue = 0, this.costOfLivingSortValue = 0, this.rentCostSortValue = 0,
    this.groceriesCostSortValue = 0, this.restaurantCostSortValue = 0, this.name = 'Default'
  })
   : selectedCountries  = selectedCountries ?? [],
     selectedThemes = selectedThemes ?? [];

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  // App State variable
  String? name = 'Default';

  // Filter Variable
  String? region;
  String? language;
  List<String> selectedCountries = [];
  List<String> selectedThemes = [];

  // Ranking
  bool shanghaiRankedOnly = false;
  bool icuRankedOnly = false;

  // Fees slider Variable
  bool noAdditionalFees = false;
  bool feesLimit = false;
  double feesMax = 0;

  // Gpa Filters
  bool noGpaRequired = false;
  bool gpaRequiredLimit = false;
  double gpaRequiredMax = 0;

  // English filters
  bool tepitechRequiredLimit = false;
  bool TOEFLRequiredLimit = false;
  bool IELTSRequiredLimit = false;
  bool TOEICRequiredLimit = false;
  bool duolingoRequiredLimit = false;
  // English filters value
  double tepitechRequiredMax = 0;
  double TOEFLRequiredMax = 0;
  double IELTSRequiredMax = 0;
  double TOEICRequiredMax = 0;
  double duolingoRequiredMax = 0;

  // Sort Activation Variable
  bool shanghaiRankedSort = false;
  bool icuRankedSort = false;
  bool costOfLivingSort = false;
  bool rentCostSort = false;
  bool groceriesCostSort = false;
  bool restaurantCostSort = false;
  // Sort Sliders Variable
  double shanghaiRankedSortValue = 1;
  double icuRankedSortValue = 1;
  double costOfLivingSortValue = 1;
  double rentCostSortValue = 1;
  double groceriesCostSortValue = 1;
  double restaurantCostSortValue = 1;

  // List of university Not to changed so final
  @JsonKey(ignore: true) List<University> unis = [];

  // Filter and sort variable result
  @JsonKey(ignore: true) List<University> filteredAndSortedUnis = [];
  @JsonKey(ignore: true) University? selectedUni;

  void filterUniversity() {
    filteredAndSortedUnis = unis;
    if (region != null && region != 'None') {
      filteredAndSortedUnis = UniversityFilterHelper.filterRegion(filteredAndSortedUnis, region!);
    }
    if (selectedCountries.isNotEmpty) {
      filteredAndSortedUnis = UniversityFilterHelper.filterCountries(filteredAndSortedUnis, selectedCountries);
    }
    if (selectedThemes.isNotEmpty) {
      filteredAndSortedUnis = UniversityFilterHelper.filterThemes(filteredAndSortedUnis, selectedThemes);
    }
    if (language != null && language != 'None') {
      filteredAndSortedUnis = UniversityFilterHelper.filterLanguage(filteredAndSortedUnis, language!);
    }
    if (shanghaiRankedOnly) {
      filteredAndSortedUnis = UniversityFilterHelper.filterShanghaiOnly(filteredAndSortedUnis);
    }
    if (icuRankedOnly) {
      filteredAndSortedUnis = UniversityFilterHelper.filterIcuRankedOnly(filteredAndSortedUnis);
    }
    if (noAdditionalFees) {
      filteredAndSortedUnis = UniversityFilterHelper.filterNoFees(filteredAndSortedUnis);
    }
    if (feesLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterFeesInferior(filteredAndSortedUnis, feesMax);
    }
    if (noGpaRequired) {
      filteredAndSortedUnis = UniversityFilterHelper.filterNoGPA(filteredAndSortedUnis);
    }
    if (gpaRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterGpaInferior(filteredAndSortedUnis, gpaRequiredMax);
    }
    if (tepitechRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterTepitechInferior(filteredAndSortedUnis, tepitechRequiredMax);
    }
    if (TOEFLRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterTOEFLInferior(filteredAndSortedUnis, TOEFLRequiredMax);
    }
    if (IELTSRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterIELTSInferior(filteredAndSortedUnis, IELTSRequiredMax);
    }
    if (TOEICRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterTOEICInferior(filteredAndSortedUnis, TOEICRequiredMax);
    }
    if (duolingoRequiredLimit) {
      filteredAndSortedUnis = UniversityFilterHelper.filterDuolingoInferior(filteredAndSortedUnis, duolingoRequiredMax);
    }
  }
  void sortUniversity() {
    filteredAndSortedUnis = UniversitySorterHelper.globalSort(
      unis: filteredAndSortedUnis,
      shanghaiWeight: shanghaiRankedSort ? shanghaiRankedSortValue : null,
      icuWeight: icuRankedSort ? icuRankedSortValue : null,
      costOfLivingWeight: costOfLivingSort ? costOfLivingSortValue : null,
      rentCostWeight: rentCostSort ? rentCostSortValue : null,
      groceriesCostWeight: groceriesCostSort ? groceriesCostSortValue : null,
      restaurantCostWeight: restaurantCostSort ? restaurantCostSortValue : null,
    );
  }
  void setSliders() {
    tepitechRequiredMax = UniversityInformationHelper.minTepitech(unis);
    TOEFLRequiredMax = UniversityInformationHelper.minTOEFL(unis);
    IELTSRequiredMax = UniversityInformationHelper.minIELTS(unis);
    TOEICRequiredMax = UniversityInformationHelper.minTOEIC(unis);
    duolingoRequiredMax = UniversityInformationHelper.minDuolingo(unis);
  }

  void load(AppState preset) {
    print('Loading preset ${preset.name}');
    // App State variable
    name = preset.name;

    region = preset.region;
    language = preset.language;
    selectedCountries = preset.selectedCountries;
    selectedThemes = preset.selectedThemes;

    // Ranking
    shanghaiRankedOnly = preset.shanghaiRankedOnly;
    icuRankedOnly = preset.icuRankedOnly;

    // Fees slider Variable
    noAdditionalFees = preset.noAdditionalFees;
    feesLimit = preset.feesLimit;
    feesMax = preset.feesMax;

    // Gpa Filters
    noGpaRequired = preset.noGpaRequired;
    gpaRequiredLimit = preset.gpaRequiredLimit;
    gpaRequiredMax = preset.gpaRequiredMax;

    // English filters
    tepitechRequiredLimit = preset.tepitechRequiredLimit;
    TOEFLRequiredLimit = preset.TOEFLRequiredLimit;
    IELTSRequiredLimit = preset.IELTSRequiredLimit;
    TOEICRequiredLimit = preset.TOEICRequiredLimit;
    duolingoRequiredLimit = preset.duolingoRequiredLimit;
    // English filters value
    tepitechRequiredMax = preset.tepitechRequiredMax;
    TOEFLRequiredMax = preset.TOEFLRequiredMax;
    IELTSRequiredMax = preset.IELTSRequiredMax;
    TOEICRequiredMax = preset.TOEICRequiredMax;
    duolingoRequiredMax = preset.duolingoRequiredMax;

    // Sort Activation Variable
    shanghaiRankedSort = preset.shanghaiRankedSort;
    icuRankedSort = preset.icuRankedSort;
    costOfLivingSort = preset.costOfLivingSort;
    rentCostSort = preset.rentCostSort;
    groceriesCostSort = preset.groceriesCostSort;
    restaurantCostSort = preset.restaurantCostSort;
    // Sort Sliders Variable
    shanghaiRankedSortValue = preset.shanghaiRankedSortValue;
    icuRankedSortValue = preset.icuRankedSortValue;
    costOfLivingSortValue = preset.costOfLivingSortValue;
    rentCostSortValue = preset.rentCostSortValue;
    groceriesCostSortValue = preset.groceriesCostSortValue;
    restaurantCostSortValue = preset.restaurantCostSortValue;

    filterUniversity();
    sortUniversity();
    notifyListeners();
  }

}