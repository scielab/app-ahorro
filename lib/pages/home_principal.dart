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
  HomePage(),
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
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 3),
              blurRadius: 7.0,
              spreadRadius: 1,
            )
          ],
          currentIndex: _selectedTab,
          dotIndicatorColor: const Color.fromARGB(255, 204, 79, 79),
          unselectedItemColor: Colors.grey[300],
          splashBorderRadius: 50,
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home,color: Colors.black87),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.search,color: Colors.black87),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.analytics,color: Colors.black87),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.self_improvement_outlined,color: Colors.black87,),
              selectedColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
