import 'package:equatable/equatable.dart';

class LifeEvent extends Equatable {
  final String? id;
  final int impactRating;
  final String description;

  const LifeEvent({
    this.id,
    required this.description,
    required this.impactRating,
  });

  @override
  List<Object?> get props => [id, impactRating, description];
}
