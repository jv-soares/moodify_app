import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _LegendItem(
            label: 'Episódio',
            indicatorGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.error,
              ],
            ),
          ),
        ),
        Expanded(
          child: _LegendItem(
            label: 'Sono',
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Expanded(
          child: _LegendItem(
            label: 'Humor',
            indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color? indicatorColor;
  final Gradient? indicatorGradient;

  const _LegendItem({
    required this.label,
    this.indicatorColor,
    this.indicatorGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 8,
          decoration: BoxDecoration(
            gradient: indicatorGradient,
            color: indicatorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
