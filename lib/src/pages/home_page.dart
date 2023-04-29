import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/diary_dashboard_page.dart';
import 'package:moodify_app/src/pages/statistics/statistics_page.dart';

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
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedFontSize: Theme.of(context).textTheme.bodySmall!.fontSize!,
        unselectedFontSize: Theme.of(context).textTheme.bodySmall!.fontSize!,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
