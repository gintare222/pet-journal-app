class Pet {
  String name;
  DateTime birthDate;
  String gender;

  Pet({
    required this.name, 
    required this.birthDate,
    required this.gender,
    });

  int get ageInDays {
    return DateTime.now().difference(birthDate).inDays;
  }

  int get ageInMonths {
    final now = DateTime.now();
    int months = (now.year - birthDate.year) * 12 + now.month - birthDate.month;
    if (now.day < birthDate.day) {
      months = -1;
    }
    return months;
  }

  int get ageInYears {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      years = -1;
    }
    return years;
  }
}