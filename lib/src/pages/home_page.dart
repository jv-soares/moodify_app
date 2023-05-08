import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/diary_dashboard_page.dart';
import 'package:moodify_app/src/pages/statistics/statistics_page.dart';

import '../app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = const [
    DiaryDashboardPage(),
    StatisticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.diaryForm);
        },
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        selectedFontSize: theme.textTheme.bodySmall!.fontSize!,
        unselectedFontSize: theme.textTheme.bodySmall!.fontSize!,
        selectedItemColor: theme.colorScheme.onPrimary,
        unselectedItemColor: theme.colorScheme.onPrimaryContainer,
        onTap: (value) {
          setState(() => _selectedIndex = value);
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Diário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estatísticas',
          ),
        ],
      ),
    );
  }
}
