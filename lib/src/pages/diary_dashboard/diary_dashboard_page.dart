import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/widgets/full_screen_info.dart';
import 'package:provider/provider.dart';

import '../../widgets/home_app_bar.dart';
import 'components/diary_entry_draggable_bottom_sheet.dart';
import 'components/episodes_chart.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return Scaffold(
      appBar: const HomeAppBar(),
      body: notifier.isEmpty
          ? const FullScreenInfo(
              svgAsset: 'assets/illustrations/undraw_add_notes.svg',
              title: 'Nenhum registro por aqui!',
              description:
                  'Comece adicionando o seu primeiro registro. Eles poderão ser vistos aqui.',
            )
          : const Stack(
              children: [
                EpisodesChart(),
                DiaryEntryDraggableBottomSheet(),
              ],
            ),
    );
  }
}
