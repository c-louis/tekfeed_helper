import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_state.dart';
import 'package:tekfeed_helper/models/university.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tekfeed_helper/widgets/filter_list.dart';
import 'package:tekfeed_helper/widgets/sorter_list.dart';
import 'package:tekfeed_helper/widgets/university_details.dart';

class UniversityMobilePage extends StatefulWidget {
  UniversityMobilePage();

  @override
  State<UniversityMobilePage> createState() => _UniversityMobilePageState();
}

class _UniversityMobilePageState extends State<UniversityMobilePage> {
  _UniversityMobilePageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Widget body;
    if (appState.selectedUni == null) {
      body = ListView.separated(
        itemCount: appState.filteredAndSortedUnis.length,
        itemBuilder: (BuildContext context, int idx) {
          University uni = appState.filteredAndSortedUnis[idx];
          return ListTile(
            leading: SvgPicture.network(
              uni.country!.flag,
              height: 16,
            ),
            title: Text(uni.school),
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
              appState.selectedUni = uni;
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
        selectedUni: appState.selectedUni!,
        closeWindow: () {
          appState.selectedUni = null;
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
                          content: FilterList(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            onChanged: () {
                              setStateFilter(() {});
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                appState.filterUniversity();
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
                              content: SorterList(
                                onChanged: () {
                                  setStateFilter(() {
                                  });
                                },
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      appState.sortUniversity();
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