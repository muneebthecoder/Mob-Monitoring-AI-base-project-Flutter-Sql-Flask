import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mob_monitoring/Screens/AllMobList.dart';
import 'package:mob_monitoring/Screens/Dashboard.dart';
import 'package:mob_monitoring/Screens/Profile.dart';
import 'package:mob_monitoring/Screens/TaskScreenMobDetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Widget> widgetScreen = <Widget>[
    DashboardScreen(),
    AllMobListScreen(),
    TaskScreenDetails(),
    UserProfileScreen(),
  ];
  void _onItemTapped(int ind) {
    setState(() {
      index = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        indicatorColor: Colors.black.withOpacity(0.8),
        surfaceTintColor: Colors.white,
        selectedIndex: index,
        height: 70,
        destinations: [
          NavigationDestination(
            icon: Icon(Iconsax.home),
            label: "Home",
          ),
          NavigationDestination(icon: Icon(Iconsax.map_1), label: "Mob List"),
          NavigationDestination(
              icon: Icon(Iconsax.location), label: "Simulation"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ],
      ),
      body: widgetScreen[index],
    );
  }
}
