import 'package:tekfeed_helper/models/university.dart';

class UniversityFilterHelper {
  static List<University> filterRegion(List<University> unis, String region) {
    List<University> filtered = [];

    for (var uni in unis) {
      if (uni.country!.region == region) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterShanghaiOnly(List<University> unis) {
    List<University> filtered = [];

    for (var uni in unis) {
      if (uni.shanghaiRank != null) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterIcuRankedOnly(List<University> unis) {
    List<University> filtered = [];

    for (var uni in unis) {
      if (uni.icuRank != null) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterLanguage(List<University> filteredUnis, String language) {
    List<University> filtered = [];

    for (var uni in filteredUnis) {
      if (uni.language == language) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterNoFees(List<University> filteredUnis) {
    List<University> filtered = [];

    for (var uni in filteredUnis) {
      if (uni.additionalFees == 0) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterFeesInferior(List<University> filteredUnis, double value) {
    List<University> filtered = [];

    for (var uni in filteredUnis) {
      if (uni.additionalFees < value) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterNoGPA(List<University> filteredUnis) {
    List<University> filtered = [];

    for (var uni in filteredUnis) {
      if (uni.gpa == 0) {
        filtered.add(uni);
      }
    }
    return filtered;
  }

  static List<University> filterGpaInferior(List<University> filteredUnis, double value) {
    List<University> filtered = [];

    for (var uni in filteredUnis) {
      if (uni.gpa <= value) {
        filtered.add(uni);
      }
    }
    return filtered;
  }
}