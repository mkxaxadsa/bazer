import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/features/main/components/bottom_bar.dart';
import 'package:finance/features/main/home/home_screen.dart';
import 'package:finance/features/main/news/news_screen.dart';
import 'package:finance/features/main/settings/settings_screen.dart';
import 'package:finance/features/main/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages = [
    const HomeScreen(),
    const NewsScreen(),
    const StatisticsScreen(),
    const SettingsScreen(),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF0D2144), Color(0xFF1B3D7A)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  pages[currentPageIndex].expanded(),
                  BottomBarWidget(
                    currentPageIndex: currentPageIndex,
                    onChanged: (pageIndex) {
                      setState(() {
                        currentPageIndex = pageIndex;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
