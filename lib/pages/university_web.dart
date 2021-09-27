import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_account.dart';
import 'package:tekfeed_helper/models/app_state.dart';
import 'package:tekfeed_helper/widgets/filter_list.dart';
import 'package:tekfeed_helper/widgets/presets.dart';
import 'package:tekfeed_helper/widgets/sorter_list.dart';
import 'package:tekfeed_helper/widgets/university_details.dart';

class UniversityWebPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UniversityWebPageState();
}

class _UniversityWebPageState extends State<UniversityWebPage> {
  _UniversityWebPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    AppAccount appAccount = Provider.of<AppAccount>(context);
    return Scaffold(
      appBar: !appAccount.isLogin ? null
        : AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(appAccount.login.title ?? appAccount.login.firstname ?? 'No name'),
            if (appAccount.login.gpa != null && appAccount.login.gpa!.length > 0)
              Text('GPA : ${appAccount.login.gpa![0].gpa}'),
            Text('Promo : ${appAccount.login.promo ?? 'Unknown Promotion'}'),
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Presets();
                  },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.save),
                  Text(' Presets'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FilterList(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_alt),
                      Text('Filter'),
                    ],
                  ),
                  onChanged: () {
                    appState.filterUniversity();
                    setState(() {});
                  },
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
            ),
          ),
          if (appState.selectedUni == null)
            Expanded(
              flex: 6,
              child: Card(
                child: SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(label: Text('Flag')),
                      DataColumn(label: Text('School name')),
                      DataColumn(label: Text('Uni Language')),
                      DataColumn(label: Text('Shanghai Rank')),
                      DataColumn(label: Text('ICU Rank')),
                    ],
                    rows: appState.filteredAndSortedUnis.map((uni) => DataRow(
                      onSelectChanged: (bool? value) {
                        appState.selectedUni = uni;
                        setState(() {});
                      },
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
          if (appState.selectedUni != null)
            Expanded(
                flex: 6,
                child: UniversityDetails(
                  selectedUni: appState.selectedUni!,
                  closeWindow: () {
                    appState.selectedUni = null;
                    setState(() {
                    });
                  },
                )
            ),
          Expanded(
            flex: 2,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SorterList(
                  mainAxisSize: MainAxisSize.max,
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sort),
                      Text('Sorter'),
                    ],
                  ),
                  onChanged: () {
                    appState.sortUniversity();
                    setState(() {
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
