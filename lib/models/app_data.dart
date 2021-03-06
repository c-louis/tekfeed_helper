import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_account.dart';
import 'package:tekfeed_helper/models/university.dart';

import 'app_state.dart';
import 'country.dart';

class AppData {
  List<University> unis = [];
  List<Country> countries = [];

  Future<void> loadData(context) async {
    await loadUnis();
    await loadCountries();
    await Provider.of<AppAccount>(context, listen: false).loadLogin();
    await Provider.of<AppAccount>(context, listen: false).loadPresets();
    Provider.of<AppState>(context, listen: false).unis = unis;
    Provider.of<AppState>(context, listen: false).filterUniversity();
    Provider.of<AppState>(context, listen: false).sortUniversity();
    Provider.of<AppState>(context, listen: false).setSliders();
  }

  Future<void> loadUnis() async {
    unis = await University.load();
  }

  Future<void> loadCountries() async {
    countries = await Country.load();
    await this.setCostOfLivingsOnCountry();
    await this.setCountryOnUniversity();
  }

  Future<void> setCostOfLivingsOnCountry() async {
    List<CostOfLiving> preCostOfLivings = await CostOfLiving.load();
    List<CostOfLiving> costOfLivings = [];
    const Map<String, String> exceptionsCOL = {
      'South Korea': 'Korea (Republic of)',
      'Palestine': 'Palestine, State of',
      'Trinidad And Tobago': 'Trinidad and Tobago',
      'Ivory Coast': "Côte d'Ivoire",
      'Iran': 'Iran (Islamic Republic of)',
      'Bosnia And Herzegovina': 'Bosnia and Herzegovina',
      'Vietnam': 'Viet Nam',
      'Russia': 'Russian Federation',
      'North Macedonia': 'Macedonia (the former Yugoslav Republic of)',
      'Syria': 'Syrian Arab Republic',
      'Kosovo (Disputed Territory)': 'Republic of Kosovo',
    };
    CostOfLiving france = preCostOfLivings.firstWhere((element) => element.countryName == 'France');
    for (CostOfLiving col in preCostOfLivings) {
      var c = CostOfLiving(
        col.countryName,
        col.costOfLivingIndex - france.costOfLivingIndex,
        col.rentIndex - france.rentIndex,
        col.costOfLivingPlusRentIndex - france.costOfLivingPlusRentIndex,
        col.groceriesIndex - france.groceriesIndex,
        col.restaurantPriceIndex - france.restaurantPriceIndex,
        col.localPurchasingPowerIndex - france.localPurchasingPowerIndex,
      );
      costOfLivings.add(c);
    }

    int notFound = 0;
    costOfLivings.forEach((costOfLiving) {
      String name = costOfLiving.countryName;
      if (exceptionsCOL[name] != null) {
        name = exceptionsCOL[costOfLiving.countryName]!;
      }
      Country country = countries.firstWhere(
            (element) => element.name == name || element.nativeName == name,
        orElse: () => Country.empty(),
      );
      if (country.name != 'UNKNOWN') {
        country.costOfLiving = costOfLiving;
      } else {
        notFound++;
      }
    });
    print('Cost of Living not linked to a country : $notFound/${costOfLivings.length}');
  }

  Future<void> setCountryOnUniversity() async {
    const Map<String, String> exceptionsUNI = {
      'Chili': 'Chile',
      'USA': 'United States of America',
      'South Korea': 'Korea (Republic of)',
      'Russia': 'Russian Federation',
      'UK': 'United Kingdom of Great Britain and Northern Ireland'
    };

    int notFound = 0;
    unis.forEach((uni) {
      String name = uni.countryName;
      if (exceptionsUNI[name] != null) {
        name = exceptionsUNI[name]!;
      }
      Country country = countries.firstWhere(
            (element) => element.name == name || element.nativeName == name,
        orElse: () => Country.empty(),
      );
      if (country.name != 'UNKNOWN') {
        uni.country = country;
      } else {
        notFound++;
      }
    });
    print('University not linked to a Country : $notFound/${unis.length}');
  }

}