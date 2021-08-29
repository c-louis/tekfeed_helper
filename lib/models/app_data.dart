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
    unis = await University.loadFromAssets();
  }

  Future<void> loadCountries() async {
    Stopwatch s = new Stopwatch()..start();
    countries = await Country.loadFromApi();
    print('Time to find countries : ${s.elapsed}');
    s.reset();
    await this.setCostOfLivingsOnCountry();
    print('Time to find cost of living : ${s.elapsed}');
    s.reset();
    await this.setCountryOnUniversity();
    print('Time to set country on University : ${s.elapsed}');
    s.reset();
    await this.setShanghaiRankedUniversity();
    print('Time to find shanghai rank : ${s.elapsed}');
    s.reset();
    await this.setIcuRankOnUniversity();
    print('Time to find icu ranked : ${s.elapsed}');
    s.stop();
  }

  Future<void> setCostOfLivingsOnCountry() async {
    Map<String, CostOfLiving> costOfLivings = await CostOfLiving.scrapFromWeb();
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
    costOfLivings.forEach((name, costOfLiving) {
      if (exceptionsCOL[name] != null) {
        name = exceptionsCOL[name]!;
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

  Future<void> setShanghaiRankedUniversity() async {
    int notFound = 0;
    List<ShanghaiRankedUniversity> sranks = await ShanghaiRankedUniversity.loadFromAssets();
    for (var uni in unis) {
      ShanghaiRankedUniversity rank = sranks.firstWhere(
        (element) {
          if (uni.school == 'National Tsinghua University') {
            return uni.school.toLowerCase() ==
                element.universityName.toLowerCase();
          }
          return uni.school.toLowerCase().indexOf(
            element.universityName.toLowerCase()) != -1;
        },
        orElse: () => ShanghaiRankedUniversity.empty(),
      );
      if (rank.universityName == 'UNKNOWN') {
        notFound++;
      } else {
        uni.shanghaiRank = rank;
      }
    }
    print('University without Shanghai Ranking : $notFound/${unis.length}');
  }

  Future<void> setIcuRankOnUniversity() async {
    int notFound = 0;
    for (var uni in unis) {
      IcuRanking? iRank = await IcuRanking.fromPrefs(uni);
      if (iRank == null) {
        iRank = await IcuRanking.fromScrapWithUni(uni);
        if (iRank.worldRank != -1 && iRank.nationalRank != -1) {
          iRank.save(uni);
        }
      }
      if (iRank.worldRank == -1 && iRank.nationalRank == -1) {
        notFound++;
      } else {
        uni.icuRank = iRank;
      }
    }
    print('There is $notFound/${unis.length} without IcuRanking found !');
  }
}