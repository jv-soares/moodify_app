import 'package:equatable/equatable.dart';

class TakenMedication extends Equatable {
  final String? id;
  final String name;
  final int tabletsTaken;
  final Dose dose;

  const TakenMedication({
    this.id,
    required this.name,
    required this.tabletsTaken,
    required this.dose,
  });

  TakenMedication incrementedTablets() =>
      copyWith(tabletsTaken: tabletsTaken + 1);

  TakenMedication decrementedTablets() =>
      copyWith(tabletsTaken: tabletsTaken - 1);

  TakenMedication copyWith({
    String? id,
    String? name,
    int? tabletsTaken,
    Dose? dose,
  }) {
    return TakenMedication(
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
  final UnitOfMeasurement unitOfMeasurement;

  const Dose(this.value, this.unitOfMeasurement);

  @override
  List<Object?> get props => [value, unitOfMeasurement];

  @override
  String toString() {
    if (_hasDecimal) {
      return '$value ${unitOfMeasurement.name}';
    } else {
      return '${value.truncate()} ${unitOfMeasurement.name}';
    }
  }

  bool get _hasDecimal => value % 1 != 0;
}

enum UnitOfMeasurement { ml, mg, g }
