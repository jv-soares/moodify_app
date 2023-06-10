import 'package:flutter/material.dart';

import '../models/life_event.dart';
import 'moodify_primary_container.dart';

class LifeEventContainer extends StatelessWidget {
  final LifeEvent lifeEvent;

  const LifeEventContainer(this.lifeEvent, {super.key});

  @override
  Widget build(BuildContext context) {
    return MoodifyPrimaryContainer(
      child: Row(
        children: [
          Expanded(
            child: Text(
              lifeEvent.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Center(
              child: Text(
                _formattedImpactRating,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _formattedImpactRating {
    final rating = lifeEvent.impactRating;
    return switch (rating) { > 0 => '+$rating', _ => '$rating' };
  }
}
