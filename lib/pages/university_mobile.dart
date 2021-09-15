import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekfeed_helper/helpers/university_filter.dart';
import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/helpers/university_sorter.dart';
import 'package:tekfeed_helper/models/university.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tekfeed_helper/widgets/dropdown_filter.dart';
import 'package:tekfeed_helper/widgets/filter.dart';
import 'package:tekfeed_helper/widgets/sorter.dart';
import 'package:tekfeed_helper/widgets/university_details.dart';

class UniversityMobilePage extends StatefulWidget {
  List<University> unis;

  UniversityMobilePage(this.unis);

  @override
  State<UniversityMobilePage> createState() => _UniversityMobilePageState(unis);
}

class _UniversityMobilePageState extends State<UniversityMobilePage> {
  final List<University> unis;
  late List<University> filteredUnis;
  University? selectedUni;

  // Filter Variable
  String? region;
  String? language;
  bool shanghaiRankedOnly = false;
  bool icuRankedOnly = false;
  bool noAdditionalFees = false;
  // Fees slider Variable
  bool feesLimit = false;
  double feesMax = 0;
  // Gpa Filters
  bool noGpaRequired = false;
  bool gpaRequiredLimit = false;
  double gpaRequiredMax = 0;

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

  _UniversityMobilePageState(this.unis);

  @override
  void initState() {
    filteredUnis = unis;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    filteredUnis = UniversitySorterHelper.globalSort(
      unis: filteredUnis,
      shanghaiWeight: shanghaiRankedSort ? shanghaiRankedSortValue : null,
      icuWeight: icuRankedSort ? icuRankedSortValue : null,
      costOfLivingWeight: costOfLivingSort ? costOfLivingSortValue : null,
      rentCostWeight: rentCostSort ? rentCostSortValue : null,
      groceriesCostWeight: groceriesCostSort ? groceriesCostSortValue : null,
      restaurantCostWeight: restaurantCostSort ? restaurantCostSortValue : null,
    );

    Widget body;
    if (selectedUni == null) {
      body = ListView.separated(
        itemCount: filteredUnis.length,
        itemBuilder: (BuildContext context, int idx) {
          University uni = filteredUnis[idx];
          return ListTile(
            leading: SvgPicture.network(
              uni.country!.flag,
              height: 16,
            ),
            title: Text(uni.school + ' ' + uni.additionalFees.toString()),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (uni.shanghaiRank != null)
                  Text('S:${uni.shanghaiRank!.worldRank}'),
                if (uni.icuRank != null)
                  Text('ICU:${uni.icuRank!.worldRank}'),
              ],
            ),
            onTap: () {
              selectedUni = uni;
              setState(() {
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 2,
          );
        },
      );
    } else {
      body = UniversityDetails(
        selectedUni: selectedUni!,
        closeWindow: () {
          selectedUni = null;
          setState(() {
          });
        },
      );
    }

    return Scaffold(
      floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, setStateFilter) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownFilter<String>(
                                name: 'Region',
                                items: UniversityInformationHelper.getUniversityRegions(unis)
                                    .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))
                                ).toList(),
                                value: region,
                                onUpdate: (String? newRegion) {
                                  region = newRegion;
                                  setStateFilter(() {});
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
                                  setStateFilter(() {});
                                },
                              ),
                              Filter(
                                name: 'Shanghai Ranked',
                                value: shanghaiRankedOnly,
                                onChanged: (bool? status) {
                                  shanghaiRankedOnly = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              Filter(
                                name: 'Icu Ranked',
                                value: icuRankedOnly,
                                onChanged: (bool? status) {
                                  icuRankedOnly = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              Filter(
                                name: 'No Additional Fees',
                                value: noAdditionalFees,
                                onChanged: (bool? status) {
                                  noAdditionalFees = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              Filter(
                                name: 'Additional Fees limit',
                                value: feesLimit,
                                onChanged: (bool? status) {
                                  feesLimit = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              if (feesLimit)
                                Row(
                                  children: [
                                    Text(UniversityInformationHelper.minFee(unis).toString()),
                                    Column(
                                      children: [
                                        Slider(
                                          min: UniversityInformationHelper.minFee(unis),
                                          max: UniversityInformationHelper.maxFee(unis) + 1,
                                          value: feesMax < UniversityInformationHelper.maxFee(unis) ? feesMax : UniversityInformationHelper.maxFee(unis),
                                          onChanged: (double? value) {
                                            feesMax = value ?? 0;
                                            setStateFilter(() {});
                                          },
                                        ),
                                        Text(feesMax.toStringAsFixed(2)),
                                      ],
                                    ),
                                    Text(UniversityInformationHelper.maxFee(unis).toString()),
                                  ],
                                ),
                              Filter(
                                name: 'No GPA required',
                                value: noGpaRequired,
                                onChanged: (bool? status) {
                                  noGpaRequired = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              Filter(
                                name: 'Gpa Required limit',
                                value: gpaRequiredLimit,
                                onChanged: (bool? status) {
                                  gpaRequiredLimit = status ?? false;
                                  setStateFilter(() {});
                                },
                              ),
                              if (gpaRequiredLimit)
                                Row(
                                  children: [
                                    Text(UniversityInformationHelper.minGpa(unis).toString()),
                                    Column(
                                      children: [
                                        Slider(
                                          min: UniversityInformationHelper.minGpa(unis),
                                          max: UniversityInformationHelper.maxGpa(unis),
                                          value: gpaRequiredMax < UniversityInformationHelper.maxGpa(unis) ? gpaRequiredMax : UniversityInformationHelper.maxGpa(unis),
                                          onChanged: (double? value) {
                                            gpaRequiredMax = value ?? 0;
                                            setStateFilter(() {});
                                          },
                                        ),
                                        Text(gpaRequiredMax.toStringAsFixed(2)),
                                      ],
                                    ),
                                    Text(UniversityInformationHelper.maxGpa(unis).toString()),
                                  ],
                                ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
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
                                if (noAdditionalFees) {
                                  filteredUnis = UniversityFilterHelper.filterNoFees(filteredUnis);
                                }
                                if (feesLimit) {
                                  filteredUnis = UniversityFilterHelper.filterFeesInferior(filteredUnis, feesMax);
                                }
                                if (noGpaRequired) {
                                  filteredUnis = UniversityFilterHelper.filterNoGPA(filteredUnis);
                                }
                                if (gpaRequiredLimit) {
                                  filteredUnis = UniversityFilterHelper.filterGpaInferior(filteredUnis, gpaRequiredMax);
                                }
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text('Apply')
                            )
                          ],
                        );
                      }
                    );
                  }
                );
              },
              child: Icon(Icons.filter_alt),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                          builder: (BuildContext context, setStateFilter) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Sorter(
                                    label: 'Shanghai Rank',
                                    sliderValue: shanghaiRankedSortValue,
                                    checkboxValue: shanghaiRankedSort,
                                    onSliderUpdate: (double d) {
                                      shanghaiRankedSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      shanghaiRankedSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                  Sorter(
                                    label: 'ICU Rank',
                                    sliderValue: icuRankedSortValue,
                                    checkboxValue: icuRankedSort,
                                    onSliderUpdate: (double d) {
                                      icuRankedSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      icuRankedSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                  Sorter(
                                    label: 'Cost of living',
                                    sliderValue: costOfLivingSortValue,
                                    checkboxValue: costOfLivingSort,
                                    onSliderUpdate: (double d) {
                                      costOfLivingSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      costOfLivingSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                  Sorter(
                                    label: 'Rent cost',
                                    sliderValue: rentCostSortValue,
                                    checkboxValue: rentCostSort,
                                    onSliderUpdate: (double d) {
                                      rentCostSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      rentCostSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                  Sorter(
                                    label: 'Groceries cost',
                                    sliderValue: groceriesCostSortValue,
                                    checkboxValue: groceriesCostSort,
                                    onSliderUpdate: (double d) {
                                      groceriesCostSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      groceriesCostSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                  Sorter(
                                    label: 'Restaurant cost',
                                    sliderValue: restaurantCostSortValue,
                                    checkboxValue: restaurantCostSort,
                                    onSliderUpdate: (double d) {
                                      restaurantCostSortValue = d;
                                      setStateFilter(() {});
                                    },
                                    onCheckboxUpdate: (bool? b) {
                                      restaurantCostSort = b ?? false;
                                      setStateFilter(() {});
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Apply')
                                )
                              ],
                            );
                          }
                      );
                    }
                );
              },
              child: Icon(Icons.sort),
            ),
          ],
        ),
      ),
      body: body,
    );
  }

  void refresh() {
    setState(() {

    });
  }
}