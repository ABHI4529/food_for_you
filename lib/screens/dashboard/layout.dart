import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_you/screens/dashboard/explore/explore.dart';
import 'package:food_for_you/screens/dashboard/home/home.dart';
import 'package:iconsax/iconsax.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [HomeScreen(), ExploreScreen(), Container()][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.compass), label: "Explore"),
          NavigationDestination(
              icon: Icon(Iconsax.document_text), label: "History")
        ],
      ),
    );
  }
}
