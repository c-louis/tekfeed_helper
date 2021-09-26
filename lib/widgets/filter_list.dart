import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/models/app_state.dart';
import 'package:tekfeed_helper/widgets/multi_selector_filter.dart';

import 'dropdown_filter.dart';
import 'filter.dart';

class FilterList extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Function() onChanged;
  final Widget? header;

  FilterList({required this.mainAxisAlignment, required this.mainAxisSize, required this.onChanged, this.header});

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return SingleChildScrollView(
      child: Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (header != null)
          header!,
        DropdownFilter<String>(
          name: 'Region',
          items: UniversityInformationHelper.getUniversityRegions(appState.unis)
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))
          ).toList(),
          value: appState.region,
          onUpdate: (String? newRegion) {
            appState.region = newRegion;
            onChanged();
          },
        ),
        DropdownFilter<String>(
          name: 'Language',
          items: UniversityInformationHelper.getUniversityLanguages(appState.unis)
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))
          ).toList(),
          value: appState.language,
          onUpdate: (String? newLanguage) {
            appState.language = newLanguage;
            onChanged();
          },
        ),
        Filter(
          name: 'Shanghai Ranked',
          value: appState.shanghaiRankedOnly,
          onChanged: (bool? status) {
            appState.shanghaiRankedOnly = status ?? false;
            onChanged();
          },
        ),
        Filter(
          name: 'Icu Ranked',
          value: appState.icuRankedOnly,
          onChanged: (bool? status) {
            appState.icuRankedOnly = status ?? false;
            onChanged();
          },
        ),
        Filter(
          name: 'No Additional Fees',
          value: appState.noAdditionalFees,
          onChanged: (bool? status) {
            appState.noAdditionalFees = status ?? false;
            onChanged();
          },
        ),
        Filter(
          name: 'Additional Fees limit',
          value: appState.feesLimit,
          onChanged: (bool? status) {
            appState.feesLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.feesLimit)
          Row(
            children: [
              Text(UniversityInformationHelper.minFee(appState.unis).toString()),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minFee(appState.unis),
                    max: UniversityInformationHelper.maxFee(appState.unis) + 1,
                    value: appState.feesMax < UniversityInformationHelper.maxFee(appState.unis) ? appState.feesMax : UniversityInformationHelper.maxFee(appState.unis),
                    onChanged: (double? value) {
                      appState.feesMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.feesMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxFee(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'No GPA required',
          value: appState.noGpaRequired,
          onChanged: (bool? status) {
            appState.noGpaRequired = status ?? false;
            onChanged();
          },
        ),
        Filter(
          name: 'Gpa Required limit',
          value: appState.gpaRequiredLimit,
          onChanged: (bool? status) {
            appState.gpaRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.gpaRequiredLimit)
          Row(
            children: [
              Text(UniversityInformationHelper.minGpa(appState.unis).toString()),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minGpa(appState.unis),
                    max: UniversityInformationHelper.maxGpa(appState.unis),
                    value: appState.gpaRequiredMax < UniversityInformationHelper.maxGpa(appState.unis) ? appState.gpaRequiredMax : UniversityInformationHelper.maxGpa(appState.unis),
                    onChanged: (double? value) {
                      appState.gpaRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.gpaRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxGpa(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'Tepitech Required limit',
          value: appState.tepitechRequiredLimit,
          onChanged: (bool? status) {
            appState.tepitechRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.tepitechRequiredLimit)
          Row(
            children: [
              Text('Required'),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minTepitech(appState.unis),
                    max: UniversityInformationHelper.maxTepitech(appState.unis),
                    value: appState.tepitechRequiredMax < UniversityInformationHelper.maxTepitech(appState.unis) ? appState.tepitechRequiredMax : UniversityInformationHelper.maxTepitech(appState.unis),
                    onChanged: (double? value) {
                      appState.tepitechRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.tepitechRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxTepitech(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'TOEFL Required limit',
          value: appState.TOEFLRequiredLimit,
          onChanged: (bool? status) {
            appState.TOEFLRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.TOEFLRequiredLimit)
          Row(
            children: [
              Text('Required'),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minTOEFL(appState.unis),
                    max: UniversityInformationHelper.maxTOEFL(appState.unis),
                    value: appState.TOEFLRequiredMax < UniversityInformationHelper.maxTOEFL(appState.unis) ? appState.TOEFLRequiredMax : UniversityInformationHelper.maxTOEFL(appState.unis),
                    onChanged: (double? value) {
                      appState.TOEFLRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.TOEFLRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxTOEFL(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'IELTS Required limit',
          value: appState.IELTSRequiredLimit,
          onChanged: (bool? status) {
            appState.IELTSRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.IELTSRequiredLimit)
          Row(
            children: [
              Text('Required'),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minIELTS(appState.unis),
                    max: UniversityInformationHelper.maxIELTS(appState.unis),
                    value: appState.IELTSRequiredMax < UniversityInformationHelper.maxIELTS(appState.unis) ? appState.IELTSRequiredMax : UniversityInformationHelper.maxIELTS(appState.unis),
                    onChanged: (double? value) {
                      appState.IELTSRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.IELTSRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxIELTS(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'TOEIC Required limit',
          value: appState.TOEICRequiredLimit,
          onChanged: (bool? status) {
            appState.TOEICRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.TOEICRequiredLimit)
          Row(
            children: [
              Text('Required'),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minTOEIC(appState.unis),
                    max: UniversityInformationHelper.maxTOEIC(appState.unis),
                    value: appState.TOEICRequiredMax < UniversityInformationHelper.maxTOEIC(appState.unis) ? appState.TOEICRequiredMax : UniversityInformationHelper.maxTOEIC(appState.unis),
                    onChanged: (double? value) {
                      appState.TOEICRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.TOEICRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxTOEIC(appState.unis).toString()),
            ],
          ),
        Filter(
          name: 'duolingo Required limit',
          value: appState.duolingoRequiredLimit,
          onChanged: (bool? status) {
            appState.duolingoRequiredLimit = status ?? false;
            onChanged();
          },
        ),
        if (appState.duolingoRequiredLimit)
          Row(
            children: [
              Text('Required'),
              Column(
                children: [
                  Slider(
                    min: UniversityInformationHelper.minDuolingo(appState.unis),
                    max: UniversityInformationHelper.maxDuolingo(appState.unis),
                    value: appState.duolingoRequiredMax < UniversityInformationHelper.maxDuolingo(appState.unis) ? appState.duolingoRequiredMax : UniversityInformationHelper.maxDuolingo(appState.unis),
                    onChanged: (double? value) {
                      appState.duolingoRequiredMax = value ?? 0;
                      onChanged();
                    },
                  ),
                  Text(appState.duolingoRequiredMax.toStringAsFixed(2)),
                ],
              ),
              Text(UniversityInformationHelper.maxDuolingo(appState.unis).toString()),
            ],
          ),
        MultiSelectorFilter(
          name: 'Countries',
          options: UniversityInformationHelper.getUniversityCountries(appState.unis),
          onChanged: (List<String> newSelected) {
            appState.selectedCountries = newSelected;
            onChanged();
          },
          selectedValues: appState.selectedCountries,
        ),
        MultiSelectorFilter(
          name: 'Themes',
          options: UniversityInformationHelper.getUniversityThemes(appState.unis),
          onChanged: (List<String> newSelected) {
            appState.selectedThemes = newSelected;
            onChanged();
          },
          selectedValues: appState.selectedThemes,
        ),
      ],
      ),
    );
  }
}