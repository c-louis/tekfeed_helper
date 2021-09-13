import 'package:tekfeed_helper/models/university.dart';

import 'country.dart';

class AppData {
  List<University> unis = [];
  List<Country> countries = [];

  Future<void> loadData() async {
    await loadUnis();
    await loadCountries();
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
    List<CostOfLiving> costOfLivings = await CostOfLiving.load();
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