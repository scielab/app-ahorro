import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/controllers/progress/progress_controller.dart';
import 'package:app/pages/activity/activity_page.dart';
import 'package:app/pages/conf/settings_page.dart';
import 'package:app/pages/guild/guild_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/progress/progress.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:get/get.dart';

List routes = [
  //HomePage(),
  ActivityPage(),
  GuildPage(),
  ProgressPage(),
  SettingsPage(),
];

class HomePagePrincipal extends StatefulWidget {
  const HomePagePrincipal({super.key});

  @override
  State<HomePagePrincipal> createState() => _HomePagePrincipalState();
}

class _HomePagePrincipalState extends State<HomePagePrincipal>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BudgetController());
    Get.put(ProgressController());

    return Scaffold(
      backgroundColor:Colors.black.withOpacity(0.1),
      extendBodyBehindAppBar: true,
      extendBody: true,      
      body: routes[
          _selectedTab], //bottomNavigationBar: ButtonNavigatorBarPrimary(),

      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 160,
        child: DotNavigationBar(
          backgroundColor: const Color.fromARGB(255, 17, 17, 17),
          currentIndex: _selectedTab,
          dotIndicatorColor: const Color.fromARGB(255, 204, 79, 79),
          unselectedItemColor: Colors.grey[300],
          splashBorderRadius: 50,
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Colors.white,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
              selectedColor: Colors.white,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.analytics),
              selectedColor: Colors.white,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.self_improvement_outlined),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
