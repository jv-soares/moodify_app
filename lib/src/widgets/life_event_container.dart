import 'package:flutter/material.dart';

import '../models/life_event.dart';
import 'moodify_primary_container.dart';

class LifeEventContainer extends StatelessWidget {
  final LifeEvent lifeEvent;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const LifeEventContainer(
    this.lifeEvent, {
    super.key,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return MoodifyPrimaryContainer(
      popupItems: _maybeBuildPopupItems(),
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

  List<PopupMenuEntry>? _maybeBuildPopupItems() {
    return onEditPressed == null || onDeletePressed == null
        ? null
        : [
            PopupMenuItem(
              onTap: onEditPressed,
              child: const Text('Editar'),
            ),
            PopupMenuItem(
              onTap: onDeletePressed,
              child: const Text('Excluir'),
            ),
          ];
  }

  String get _formattedImpactRating {
    final rating = lifeEvent.impactRating;
    return switch (rating) { > 0 => '+$rating', _ => '$rating' };
  }
}
