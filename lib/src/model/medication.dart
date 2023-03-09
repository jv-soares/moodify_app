import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final String id;
  final String name;
  final int tabletsTaken;
  final Dose dose;

  const Medication({
    required this.id,
    required this.name,
    required this.tabletsTaken,
    required this.dose,
  });

  Medication incrementedTablets() => copyWith(tabletsTaken: tabletsTaken + 1);

  Medication decrementedTablets() => copyWith(tabletsTaken: tabletsTaken - 1);

  Medication copyWith({
    String? id,
    String? name,
    int? tabletsTaken,
    Dose? dose,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      tabletsTaken: tabletsTaken ?? this.tabletsTaken,
      dose: dose ?? this.dose,
    );
  }

  @override
  List<Object?> get props => [id, name, tabletsTaken, dose];
}

class Dose extends Equatable {
  final double value;
  final String unitOfMeasurement;

  const Dose(this.value, this.unitOfMeasurement);

  @override
  List<Object?> get props => [value, unitOfMeasurement];
}
