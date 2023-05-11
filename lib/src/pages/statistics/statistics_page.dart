import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/statistics/components/statistics_draggable_bottom_sheet.dart';
import 'package:moodify_app/src/widgets/full_screen_info.dart';
import 'package:moodify_app/src/widgets/home_app_bar.dart';
import 'package:provider/provider.dart';

import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'components/chart_legend.dart';
import 'components/statistics_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    if (notifier.state is Loaded) {
      return Scaffold(
        appBar: const HomeAppBar(),
        body: notifier.notEnoughData
            ? const FullScreenInfo(
                svgAsset: 'assets/illustrations/undraw_visual_data.svg',
                title: 'Sem registros suficientes...',
                description:
                    'Adicione pelo menos dois registros para visualizar suas estatísticas.',
              )
            : Stack(
                children: [
                  if (notifier.state is Loaded) ...[
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 36, vertical: 16),
                          child: ChartLegend(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 48,
                          ),
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: const StatisticsChart(),
                        ),
                      ],
                    ),
                    StatisticsDraggableBottomSheet(
                      entries: (notifier.state as Loaded)
                          .entries
                          .map((e) => e.diaryEntry)
                          .whereNotNull()
                          .toList(),
                    ),
                  ]
                ],
              ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
