import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tekfeed_helper/helpers/university_filter.dart';
import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/helpers/university_sorter.dart';
import 'package:tekfeed_helper/models/university.dart';
import 'package:tekfeed_helper/widgets/dropdown_filter.dart';
import 'package:tekfeed_helper/widgets/filter.dart';
import 'package:tekfeed_helper/widgets/sorter.dart';

class UniversityWebPage extends StatefulWidget {
  final List<University> unis;

  UniversityWebPage(this.unis);

  @override
  State<StatefulWidget> createState() => _UniversityWebPageState(unis);
}

class _UniversityWebPageState extends State<UniversityWebPage> {
  final List<University> unis;
  late List<University> filteredUnis;

  // Filter Variable
  String? region;
  String? language;
  bool shanghaiRankedOnly = false;
  bool icuRankedOnly = false;

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

  _UniversityWebPageState(this.unis);

  @override
  void initState() {
    filteredUnis = unis;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteredUnis = unis;
    if (region != null && region != 'None') {
      filteredUnis = UniversityFilterHelper.filterRegion(filteredUnis, region!);
    }
    if (language != null && language != 'None') {
      filteredUnis = UniversityFilterHelper.filterLanguage(filteredUnis, language!);
    }
    if (shanghaiRankedOnly) {
      filteredUnis = UniversityFilterHelper.filterShanghaiOnly(filteredUnis);
    }
    if (icuRankedOnly) {
      filteredUnis = UniversityFilterHelper.filterIcuRankedOnly(filteredUnis);
    }
    filteredUnis = UniversitySorterHelper.globalSort(
      unis: filteredUnis,
      shanghaiWeight: shanghaiRankedSort ? shanghaiRankedSortValue : null,
      icuWeight: icuRankedSort ? icuRankedSortValue : null,
      costOfLivingWeight: costOfLivingSort ? costOfLivingSortValue : null,
      rentCostWeight: rentCostSort ? rentCostSortValue : null,
      groceriesCostWeight: groceriesCostSort ? groceriesCostSortValue : null,
      restaurantCostWeight: restaurantCostSort ? restaurantCostSortValue : null,
    );
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_alt),
                      Text('Filter'),
                    ],
                  ),
                  DropdownFilter<String>(
                    name: 'Region',
                    items: UniversityInformationHelper.getUniversityRegions(unis)
                        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))
                    ).toList(),
                    value: region,
                    onUpdate: (String? newRegion) {
                      region = newRegion;
                      setState(() {});
                    },
                  ),
                  DropdownFilter<String>(
                    name: 'Language',
                    items: UniversityInformationHelper.getUniversityLanguages(unis)
                        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))
                    ).toList(),
                    value: language,
                    onUpdate: (String? newRegion) {
                      language = newRegion;
                      setState(() {});
                    },
                  ),
                  Filter(
                    name: 'Shanghai Ranked',
                    value: shanghaiRankedOnly,
                    onChanged: (bool? status) {
                      shanghaiRankedOnly = status ?? false;
                      setState(() {});
                    },
                  ),
                  Filter(
                    name: 'Icu Ranked',
                    value: icuRankedOnly,
                    onChanged: (bool? status) {
                      icuRankedOnly = status ?? false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Card(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Flag')),
                  DataColumn(label: Text('School name')),
                  DataColumn(label: Text('Uni Language')),
                  DataColumn(label: Text('Shanghai Rank')),
                  DataColumn(label: Text('ICU Rank')),
                ],
                rows: filteredUnis.map((uni) => DataRow(
                  cells: [
                    DataCell(SvgPicture.network(uni.country!.flag, height: 32,)),
                    DataCell(Text(uni.school)),
                    DataCell(Text(uni.language)),
                    DataCell(Text((uni.shanghaiRank != null ? uni.shanghaiRank!.worldRank.toString() : ''))),
                    DataCell(Text((uni.icuRank != null ? uni.icuRank!.worldRank.toString() : ''))),
                  ],
                )).toList(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sort),
                      Text('Sorter'),
                    ],
                  ),
                  Sorter(
                    label: 'Shanghai Rank',
                    sliderValue: shanghaiRankedSortValue,
                    checkboxValue: shanghaiRankedSort,
                    onSliderUpdate: (double d) {
                      shanghaiRankedSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      shanghaiRankedSort = b ?? false;
                      setState(() {});
                    },
                  ),
                  Sorter(
                    label: 'ICU Rank',
                    sliderValue: icuRankedSortValue,
                    checkboxValue: icuRankedSort,
                    onSliderUpdate: (double d) {
                      icuRankedSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      icuRankedSort = b ?? false;
                      setState(() {});
                    },
                  ),
                  Sorter(
                    label: 'Cost of living',
                    sliderValue: costOfLivingSortValue,
                    checkboxValue: costOfLivingSort,
                    onSliderUpdate: (double d) {
                      costOfLivingSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      costOfLivingSort = b ?? false;
                      setState(() {});
                    },
                  ),
                  Sorter(
                    label: 'Rent cost',
                    sliderValue: rentCostSortValue,
                    checkboxValue: rentCostSort,
                    onSliderUpdate: (double d) {
                      rentCostSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      rentCostSort = b ?? false;
                      setState(() {});
                    },
                  ),
                  Sorter(
                    label: 'Groceries cost',
                    sliderValue: groceriesCostSortValue,
                    checkboxValue: groceriesCostSort,
                    onSliderUpdate: (double d) {
                      groceriesCostSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      groceriesCostSort = b ?? false;
                      setState(() {});
                    },
                  ),
                  Sorter(
                    label: 'Restaurant cost',
                    sliderValue: restaurantCostSortValue,
                    checkboxValue: restaurantCostSort,
                    onSliderUpdate: (double d) {
                      restaurantCostSortValue = d;
                      setState(() {});
                    },
                    onCheckboxUpdate: (bool? b) {
                      restaurantCostSort = b ?? false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
