import 'package:equatable/equatable.dart';

class LifeEvent extends Equatable {
  final int impactRating;
  final String description;

  const LifeEvent({
    required this.description,
    required this.impactRating,
  });

  @override
  List<Object?> get props => [impactRating, description];
}
