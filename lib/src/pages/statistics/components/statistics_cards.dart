import 'package:flutter/material.dart';

import '../../../models/diary_analyzer.dart';
import '../../../models/diary_entry.dart';

class StatisticsCards extends StatefulWidget {
  final List<DiaryEntry> entries;

  const StatisticsCards({super.key, required this.entries});

  @override
  State<StatisticsCards> createState() => _StatisticsCardsState();
}

class _StatisticsCardsState extends State<StatisticsCards> {
  late DiaryAnalyzer _analyzer;
  late EpisodeSeverityDistribution _distribution;

  @override
  void initState() {
    super.initState();
    _analyzer = DiaryAnalyzer(widget.entries);
    _distribution = _analyzer.calculateEpisodeDistribution();
  }

  @override
  void didUpdateWidget(StatisticsCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    _analyzer = DiaryAnalyzer(widget.entries);
    _distribution = _analyzer.calculateEpisodeDistribution();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatisticsAverageCard(
                label: 'Humor médio',
                value: _analyzer.averageMood,
                icon: Icons.mood,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatisticsAverageCard(
                label: 'Sono médio',
                value: _analyzer.averageHoursOfSleep,
                icon: Icons.bedtime_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _EpisodeSeverityFractionCard(
                label: 'Depressão',
                value: _distribution.depression,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _EpisodeSeverityFractionCard(
                label: 'Equilíbrio',
                value: _distribution.balanced,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _EpisodeSeverityFractionCard(
                label: 'Mania',
                value: _distribution.mania,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatisticsAverageCard extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;

  const _StatisticsAverageCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primaryContainerColor =
        Theme.of(context).colorScheme.primaryContainer;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryContainerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: onPrimaryContainerColor,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value.toStringAsFixed(0),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: onPrimaryContainerColor,
                    ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: onPrimaryContainerColor,
            ),
            child: Icon(icon, color: primaryContainerColor, size: 18),
          ),
        ],
      ),
    );
  }
}

class _EpisodeSeverityFractionCard extends StatelessWidget {
  final String label;
  final double value;

  const _EpisodeSeverityFractionCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final primaryContainerColor =
        Theme.of(context).colorScheme.primaryContainer;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryContainerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: (value * 100).toStringAsFixed(0),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: onPrimaryContainerColor,
                      ),
                ),
                TextSpan(
                  text: '%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: onPrimaryContainerColor,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: onPrimaryContainerColor,
                ),
          ),
        ],
      ),
    );
  }
}
