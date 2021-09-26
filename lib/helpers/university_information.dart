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

  static List<String> getUniversityCountries(List<University> unis) {
    List<String> countries = [];

    for (var uni in unis) {
      if (!countries.contains(uni.country!.name)) {
        countries.add(uni.country!.name);
      }
    }
    return countries;
  }

  static List<String> getUniversityThemes(List<University> unis) {
    List<String> themes = [];

    for (var uni in unis) {
      for (var theme in uni.themes) {
        if (!themes.contains(theme.name)) {
          themes.add(theme.name);
        }
      }
    }
    return themes;
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

  // GPA
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

  // TEPITECH
  static double maxTepitech(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.tepitech.isNotEmpty && double.parse(uni.tepitech) > max) {
        max = double.parse(uni.tepitech);
      }
    }
    return max;
  }
  static double minTepitech(List<University> unis) {
    double max = maxTepitech(unis);
    for (var uni in unis) {
      if (uni.tepitech.isNotEmpty && double.parse(uni.tepitech) < max) {
        max = double.parse(uni.tepitech);
      }
    }
    if (max == maxTepitech(unis)) max--;
    return max;
  }
  // TOEFL
  static double maxTOEFL(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.TOEFL.isNotEmpty && int.parse(uni.TOEFL) > max) {
        max = double.parse(uni.TOEFL);
      }
    }
    return max;
  }
  static double minTOEFL(List<University> unis) {
    double max = maxTOEFL(unis);
    for (var uni in unis) {
      if (uni.TOEFL.isNotEmpty && int.parse(uni.TOEFL) < max) {
        max = double.parse(uni.TOEFL);
      }
    }
    if (max == maxTOEFL(unis)) max--;
    return max;
  }
  // IELTS
  static double maxIELTS(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.IELTS.isNotEmpty && double.parse(uni.IELTS) > max) {
        max = double.parse(uni.IELTS);
      }
    }
    return max;
  }
  static double minIELTS(List<University> unis) {
    double max = maxIELTS(unis);
    for (var uni in unis) {
      if (uni.IELTS.isNotEmpty && double.parse(uni.IELTS) < max) {
        max = double.parse(uni.IELTS);
      }
    }
    if (max == maxIELTS(unis)) max--;
    return max;
  }
  // TOEIC
  static double maxTOEIC(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.TOEIC.isNotEmpty && int.parse(uni.TOEIC) > max) {
        max = double.parse(uni.TOEIC);
      }
    }
    return max;
  }
  static double minTOEIC(List<University> unis) {
    double max = maxTOEIC(unis);
    for (var uni in unis) {
      if (uni.TOEIC.isNotEmpty && int.parse(uni.TOEIC) < max) {
        max = double.parse(uni.TOEIC);
      }
    }
    if (max == maxTOEIC(unis)) max--;
    return max;
  }
  // TOEIC
  static double maxDuolingo(List<University> unis) {
    double max = 0;
    for (var uni in unis) {
      if (uni.duolingo.isNotEmpty && int.parse(uni.duolingo) > max) {
        max = double.parse(uni.duolingo);
      }
    }
    return max;
  }
  static double minDuolingo(List<University> unis) {
    double max = maxDuolingo(unis);
    for (var uni in unis) {
      if (uni.duolingo.isNotEmpty && int.parse(uni.duolingo) < max) {
        max = double.parse(uni.duolingo);
      }
    }
    if (max == maxDuolingo(unis)) max--;
    return max;
  }
}