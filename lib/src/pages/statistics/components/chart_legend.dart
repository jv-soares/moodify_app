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
            indicatorColor: Theme.of(context).colorScheme.primary,
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
  final Color indicatorColor;

  const _LegendItem({
    required this.label,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: indicatorColor,
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
