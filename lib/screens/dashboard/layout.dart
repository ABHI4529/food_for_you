import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_you/screens/dashboard/explore/explore.dart';
import 'package:food_for_you/screens/dashboard/history/history.dart';
import 'package:food_for_you/screens/dashboard/home/home.dart';
import 'package:iconsax/iconsax.dart';

class DashboardLayout extends ConsumerStatefulWidget {
  const DashboardLayout({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardLayoutState();
}

class _DashboardLayoutState extends ConsumerState<DashboardLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [HomeScreen(), ExploreScreen(), HistoryScreen()][_selectedIndex],
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
