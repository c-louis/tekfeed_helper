import 'package:tekfeed_helper/helpers/university_information.dart';
import 'package:tekfeed_helper/models/university.dart';

class UniversitySorterHelper {
  static List<University> alphaSort(List<University> unis) {
    unis.sort((a, b) {
      return a.school.toLowerCase().compareTo(b.school.toLowerCase());
    });
    return unis;
  }

  static List<University> globalSort({
    required List<University> unis,
    double? shanghaiWeight,
    double? icuWeight,
    double? costOfLivingWeight,
    double? rentCostWeight,
    double? groceriesCostWeight,
    double? restaurantCostWeight,
  }) {
    Map<University, double> unisRatio = {};
    int shanghaiMaxRank =     UniversityInformationHelper.shanghaiMaxRank(unis);
    int icuMaxRank =          UniversityInformationHelper.icuMaxRank(unis);
    double costOfLivingMax =  UniversityInformationHelper.costOfLivingMax(unis);
    double rentCostMax =      UniversityInformationHelper.rentCostMax(unis);
    double groceriesCostMax = UniversityInformationHelper.groceriesCostMax(unis);
    double restaurantCostMax =UniversityInformationHelper.restaurantCostMax(unis);

    for (var uni in unis) {
      double ratio = 0;
      if (shanghaiWeight != null) {
        if (uni.shanghaiRank != null) {
          ratio += ((1 - (uni.shanghaiRank!.worldRank/shanghaiMaxRank)) * shanghaiWeight);
        }
      }
      if (icuWeight != null) {
        if (uni.icuRank != null) {
          ratio += ((1 - (uni.icuRank!.worldRank/icuMaxRank)) * icuWeight);
        }
      }
      if (costOfLivingWeight != null) {
        ratio += ((1 - (uni.country!.costOfLiving!.costOfLivingIndex/costOfLivingMax)) * costOfLivingWeight);
      }
      if (rentCostWeight != null) {
        ratio += ((1 - (uni.country!.costOfLiving!.rentIndex/rentCostMax)) * rentCostWeight);
      }
      if (groceriesCostWeight != null) {
        ratio += ((1 - (uni.country!.costOfLiving!.groceriesIndex/groceriesCostMax)) * groceriesCostWeight);
      }
      if (restaurantCostWeight != null) {
        ratio += ((1 - (uni.country!.costOfLiving!.restaurantPriceIndex/restaurantCostMax)) * restaurantCostWeight);
      }
      unisRatio[uni] = ratio;
    }
    double sum = 0;
    for (var rat in unisRatio.values.toList()) {
      sum += rat;
    }
    if (sum == 0) {
      return alphaSort(unis);
    }
    unis.sort((a, b) {
      return (unisRatio[a]! < unisRatio[b]! ? 1 : -1);
    });

    return unis;
  } 
}