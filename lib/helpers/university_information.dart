import 'package:tekfeed_helper/models/university.dart';

class UniversityInformationHelper {
  static List<String> getUniversityRegions(List<University> unis) {
    List<String> regions = ['None'];

    for (var uni in unis) {
      if (!regions.contains(uni.country!.region)) {
        regions.add(uni.country!.region);
      }
    }

    return regions;
  }

  static List<String> getUniversityLanguages(List<University> unis) {
    List<String> languages = ['None'];

    for (var uni in unis) {
      if (!languages.contains(uni.language)) {
        languages.add(uni.language);
      }
    }

    return languages;
  }

  static int shanghaiMaxRank(List<University> unis) {
    int max = -1;
    for (var uni in unis) {
      if (uni.shanghaiRank != null && uni.shanghaiRank!.worldRank > max) {
        max = uni.shanghaiRank!.worldRank;
      }
    }
    return max;
  }

  static int icuMaxRank(List<University> unis) {
    int max = 0;
    for (var uni in unis) {
      if (uni.icuRank != null && uni.icuRank!.worldRank > max) {
        max = uni.icuRank!.worldRank;
      }
    }
    return max;
  }

  static double costOfLivingMax(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.country!.costOfLiving != null && uni.country!.costOfLiving!.costOfLivingIndex > max) {
        max = uni.country!.costOfLiving!.costOfLivingIndex;
      }
    }
    return max;
  }

  static double rentCostMax(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.country!.costOfLiving != null && uni.country!.costOfLiving!.rentIndex > max) {
        max = uni.country!.costOfLiving!.rentIndex;
      }
    }
    return max;
  }

  static double groceriesCostMax(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.country!.costOfLiving != null && uni.country!.costOfLiving!.groceriesIndex > max) {
        max = uni.country!.costOfLiving!.groceriesIndex;
      }
    }
    return max;
  }

  static double restaurantCostMax(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.country!.costOfLiving != null && uni.country!.costOfLiving!.restaurantPriceIndex > max) {
        max = uni.country!.costOfLiving!.restaurantPriceIndex;
      }
    }
    return max;
  }

  static double maxFee(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.additionalFees > max) {
        max = uni.additionalFees;
      }
    }
    return max;
  }

  static double minFee(List<University> unis) {
    double max = maxFee(unis);
    for (var uni in unis) {
      if (uni.additionalFees < max) {
        max = uni.additionalFees;
      }
    }
    return max;
  }

  static double maxGpa(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.gpa > max) {
        max = uni.gpa;
      }
    }
    return max;
  }

  static double minGpa(List<University> unis) {
    double max = maxGpa(unis);
    for (var uni in unis) {
      if (uni.gpa < max) {
        max = uni.gpa;
      }
    }
    return max;
  }
}