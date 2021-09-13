import 'package:flutter/material.dart';
import 'package:tekfeed_helper/models/university.dart';

import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class UniversityDetails extends StatelessWidget {
  final University selectedUni;
  final Function() closeWindow;

  UniversityDetails({required this.selectedUni, required this.closeWindow});

  @override
  Widget build(BuildContext context) {
    String currencies = '';
    String languages = '';

    selectedUni.country!.currencies.forEach((element) {
      currencies += element.name != null ? (element.name! + ' ,') : '';
    });
    selectedUni.country!.languages.forEach((element) {
      languages += element.name != null ? (element.name! + ' ,') : '';
    });
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(
              label: TextButton(
                onPressed: closeWindow,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    Text('Go back')
                  ],
                ),
              ),
            ),
            DataColumn(
              label: TextButton(
                onPressed: () {
                  js.context.callMethod('open', ['https://tekfeed.epitech.eu/#/universite/${selectedUni.tekfeedId}']);
                },
                child: Row(
                  children: [
                    Text('See on tekfeed'),
                    Icon(Icons.open_in_browser)
                  ],
                )
              )
            )
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('University Name')), DataCell(Text(selectedUni.school))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Uni Dates')), DataCell(Text(selectedUni.dates))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('University Language')), DataCell(Text(selectedUni.language))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('University GPA asked')), DataCell(Text(selectedUni.gpa.toString()))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('University DualDegree')), DataCell(Text(selectedUni.dualDegree.toString()))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Additional Fees to pay')), DataCell(Text(selectedUni.additionalFees.toString()))
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Available places')), DataCell(Text(selectedUni.places.toString()))
              ]
            ),
            if (selectedUni.icuRank != null)
              DataRow(
                cells: [
                  DataCell(Text('ICU Rank')), DataCell(
                    Text('World : ${selectedUni.icuRank!.worldRank.toString()} | Country : ${selectedUni.icuRank!.nationalRank.toString()}')
                  )
                ]
              ),
            if (selectedUni.shanghaiRank != null)
              DataRow(
                cells: [
                  DataCell(Text('Shanghai Rank')), DataCell(Text(selectedUni.shanghaiRank!.worldRank.toString()))
                ]
              ),
            DataRow(
              cells: [
                DataCell(Text('Country')), DataCell(Text(selectedUni.country!.name)),
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Region, Subregion')), DataCell(Text(selectedUni.country!.region + ', ' + selectedUni.country!.subregion)),
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Region, Subregion')), DataCell(Text(selectedUni.country!.region + ', ' + selectedUni.country!.subregion)),
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Country Capital')), DataCell(Text(selectedUni.country!.capital)),
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Country Currencies')), DataCell(Text(currencies)),
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text('Country languages')), DataCell(Text(languages)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Cost of Living')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.costOfLivingIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.costOfLivingIndex > 0 ? Colors.red : Colors.green),
                  )
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Rent cost')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.rentIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.rentIndex > 0 ? Colors.red : Colors.green),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Cost of Living + Rent cost')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.costOfLivingPlusRentIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.costOfLivingPlusRentIndex > 0 ? Colors.red : Colors.green),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Groceries')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.groceriesIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.groceriesIndex > 0 ? Colors.red : Colors.green),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Restaurant price')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.restaurantPriceIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.restaurantPriceIndex > 0 ? Colors.red : Colors.green),
                  ),
                ),
              ],
            ),DataRow(
              cells: [
                DataCell(Text('Local purchasing power')), DataCell(
                  Text(selectedUni.country!.costOfLiving!.localPurchasingPowerIndex.toStringAsPrecision(4) + '%',
                    style: TextStyle(color: selectedUni.country!.costOfLiving!.localPurchasingPowerIndex > 0 ? Colors.red : Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}