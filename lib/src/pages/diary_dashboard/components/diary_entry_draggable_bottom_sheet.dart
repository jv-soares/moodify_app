import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/life_event.dart';

import '../../../models/diary_entry.dart';
import '../../../widgets/moodify_info_chip.dart';

class DiaryEntryDraggableBottomSheet extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryEntryDraggableBottomSheet(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .65,
      minChildSize: .65,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const _Header(),
              const _LifeEventSection(
                LifeEvent(
                  impactRating: 3,
                  description:
                      'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
                ),
              ),
              const Placeholder(
                fallbackHeight: 1000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mania moderada-alta',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('EDITAR'),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              'Domingo, 17 de fevereiro',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: const [
            MoodifyInfoChip(Icons.bedtime_outlined, '7 horas'),
            MoodifyInfoChip(Icons.mood, '35'),
            MoodifyInfoChip(
              Icons.battery_charging_full,
              'Mania disfórica',
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LifeEventSection extends StatelessWidget {
  final LifeEvent lifeEvent;

  const _LifeEventSection(this.lifeEvent);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACONTECIMENTO',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
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
                      '+${lifeEvent.impactRating}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
