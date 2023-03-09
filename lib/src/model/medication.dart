class Medication {
  final String id;
  final String name;
  final int tabletsTaken;
  final Dose dose;

  Medication({
    required this.id,
    required this.name,
    required this.tabletsTaken,
    required this.dose,
  });
}

class Dose {
  final double value;
  final String unitOfMeasurement;

  Dose(this.value, this.unitOfMeasurement);
}
