import 'package:flutter/material.dart';
import 'package:tekfeed_helper/helpers/university_filter.dart';
import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/helpers/university_sorter.dart';
import 'package:tekfeed_helper/models/university.dart';

class AppState extends ChangeNotifier {
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


  void setSliders() {
    tepitechRequiredMax = UniversityInformationHelper.minTepitech(unis);
    TOEFLRequiredMax = UniversityInformationHelper.minTOEFL(unis);
    IELTSRequiredMax = UniversityInformationHelper.minIELTS(unis);
    TOEICRequiredMax = UniversityInformationHelper.minTOEIC(unis);
    duolingoRequiredMax = UniversityInformationHelper.minDuolingo(unis);
  }

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
  List<University> unis = [];

  // Filter and sort variable result
  List<University> filteredAndSortedUnis = [];
  University? selectedUni;

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
}