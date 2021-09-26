import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_state.dart';
import 'package:tekfeed_helper/widgets/sorter.dart';

class SorterList extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Function() onChanged;
  final Widget? header;

  const SorterList({Key? key, required this.onChanged, this.header, this.mainAxisAlignment = MainAxisAlignment.start, this.mainAxisSize = MainAxisSize.min}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (header != null)
          header!,
        Sorter(
          label: 'Shanghai Rank',
          sliderValue: appState.shanghaiRankedSortValue,
          checkboxValue: appState.shanghaiRankedSort,
          onSliderUpdate: (double d) {
            appState.shanghaiRankedSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.shanghaiRankedSort = b ?? false;
            onChanged();
          },
        ),
        Sorter(
          label: 'ICU Rank',
          sliderValue: appState.icuRankedSortValue,
          checkboxValue: appState.icuRankedSort,
          onSliderUpdate: (double d) {
            appState.icuRankedSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.icuRankedSort = b ?? false;
            onChanged();
          },
        ),
        Sorter(
          label: 'Cost of living',
          sliderValue: appState.costOfLivingSortValue,
          checkboxValue: appState.costOfLivingSort,
          onSliderUpdate: (double d) {
            appState.costOfLivingSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.costOfLivingSort = b ?? false;
            onChanged();
          },
        ),
        Sorter(
          label: 'Rent cost',
          sliderValue: appState.rentCostSortValue,
          checkboxValue: appState.rentCostSort,
          onSliderUpdate: (double d) {
            appState.rentCostSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.rentCostSort = b ?? false;
            onChanged();
          },
        ),
        Sorter(
          label: 'Groceries cost',
          sliderValue: appState.groceriesCostSortValue,
          checkboxValue: appState.groceriesCostSort,
          onSliderUpdate: (double d) {
            appState.groceriesCostSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.groceriesCostSort = b ?? false;
            onChanged();
          },
        ),
        Sorter(
          label: 'Restaurant cost',
          sliderValue: appState.restaurantCostSortValue,
          checkboxValue: appState.restaurantCostSort,
          onSliderUpdate: (double d) {
            appState.restaurantCostSortValue = d;
            onChanged();
          },
          onCheckboxUpdate: (bool? b) {
            appState.restaurantCostSort = b ?? false;
            onChanged();
          },
        ),
      ],
    );
  }

}