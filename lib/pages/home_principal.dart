import 'package:app/pages/account/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:get/get.dart';

import 'package:app/controllers/home/home_controller.dart';
import 'package:app/pages/activity/activity_page.dart';
import 'package:app/pages/conf/settings_page.dart';
import 'package:app/pages/guild/guild_page.dart';
import 'package:app/pages/home_page.dart';


List routes = [
  //HomePage(),
  const ActivityPage(),
  const GuildPage(),
  const HomePage(),
  const ProfilePage(),
  //const SettingsPage(),
];

class HomePagePrincipal extends StatefulWidget {
  const HomePagePrincipal({super.key});

  @override
  State<HomePagePrincipal> createState() => _HomePagePrincipalState();
}

class _HomePagePrincipalState extends State<HomePagePrincipal> with TickerProviderStateMixin {
  HomeController homeController = Get.find<HomeController>();
  
  @override
  void initState() {
    homeController.verificateDificulty();
    super.initState();
  }

  int _selectedTab = 0;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black.withOpacity(0.1),
      extendBodyBehindAppBar: true,
      extendBody: true,      
      body: routes[_selectedTab],
      bottomNavigationBar:  DotNavigationBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            marginR: const EdgeInsets.only(left: 40,right: 40),
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
                icon: const Icon(Icons.home,color: Colors.black87,size: 20,),
                selectedColor: Colors.black,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.search,color: Colors.black87,size: 20,),
                selectedColor: Colors.black,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.analytics,color: Colors.black87,size: 20,),
                selectedColor: Colors.black,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.person,color: Colors.black87,size: 20,),
                selectedColor: Colors.black,
              ),
            ],
          ),
      
      
    );
  }
}
