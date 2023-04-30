import 'package:flutter/material.dart';

import '../../../core/failures.dart';
import '../../../models/diary_analyzer.dart';
import '../../../models/diary_entry.dart';

class StatisticsCards extends StatefulWidget {
  final List<DiaryEntry> entries;

  const StatisticsCards({super.key, required this.entries});

  @override
  State<StatisticsCards> createState() => _StatisticsCardsState();
}

class _StatisticsCardsState extends State<StatisticsCards> {
  DiaryAnalyzer? _analyzer;
  EpisodeSeverityDistribution? _distribution;
  Failure? failure;

  @override
  void initState() {
    super.initState();
    try {
      _analyzer = DiaryAnalyzer(widget.entries);
      _distribution = _analyzer?.calculateEpisodeDistribution();
    } on EmptyEntriesFailure catch (e) {
      failure = e;
    }
  }

  @override
  void didUpdateWidget(StatisticsCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    try {
      _analyzer = DiaryAnalyzer(widget.entries);
      _distribution = _analyzer?.calculateEpisodeDistribution();
    } on EmptyEntriesFailure catch (e) {
      failure = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (failure is EmptyEntriesFailure) {
      return Text(failure.toString());
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatisticsAverageCard(
                label: 'Humor médio',
                value: _analyzer!.averageMood,
                icon: Icons.mood,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatisticsAverageCard(
                label: 'Sono médio',
                value: _analyzer!.averageHoursOfSleep,
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
                value: _distribution!.depression,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _EpisodeSeverityFractionCard(
                label: 'Equilíbrio',
                value: _distribution!.balanced,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _EpisodeSeverityFractionCard(
                label: 'Mania',
                value: _distribution!.mania,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatisticsAverageCard extends StatefulWidget {
  final String label;
  final double value;
  final IconData icon;

  const _StatisticsAverageCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  State<_StatisticsAverageCard> createState() => _StatisticsAverageCardState();
}

class _StatisticsAverageCardState extends State<_StatisticsAverageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _numberAnimation = _controller.drive(_buildTween());
    _controller.forward();
  }

  @override
  void didUpdateWidget(_StatisticsAverageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _numberAnimation = _controller.drive(_buildTween());
    _controller.forward();
  }

  Animatable<double> _buildTween() {
    return Tween(begin: 0.0, end: widget.value).chain(
      CurveTween(curve: Curves.easeInOutCubic),
    );
  }

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
                widget.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: onPrimaryContainerColor,
                    ),
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _numberAnimation,
                builder: (context, _) {
                  return Text(
                    _numberAnimation.value.toStringAsFixed(0),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: onPrimaryContainerColor),
                  );
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: onPrimaryContainerColor,
            ),
            child: Icon(widget.icon, color: primaryContainerColor, size: 18),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _EpisodeSeverityFractionCard extends StatefulWidget {
  final String label;
  final double value;

  const _EpisodeSeverityFractionCard({
    required this.label,
    required this.value,
  });

  @override
  State<_EpisodeSeverityFractionCard> createState() =>
      _EpisodeSeverityFractionCardState();
}

class _EpisodeSeverityFractionCardState
    extends State<_EpisodeSeverityFractionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _numberAnimation = _controller.drive(_buildTween());
    _controller.forward();
  }

  @override
  void didUpdateWidget(_EpisodeSeverityFractionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _numberAnimation = _controller.drive(_buildTween());
    _controller.forward();
  }

  Animatable<double> _buildTween() {
    return Tween(begin: 0.0, end: widget.value).chain(
      CurveTween(curve: Curves.easeInOutCubic),
    );
  }

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
          AnimatedBuilder(
            animation: _numberAnimation,
            builder: (context, _) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: (_numberAnimation.value * 100).toStringAsFixed(0),
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
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: onPrimaryContainerColor,
                ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
