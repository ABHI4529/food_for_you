import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/splash.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MailAppState();
}

class _MailAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: const Color(0xff843c0c),
              onPrimary: Colors.white,
              secondary: const Color(0xfffff2cc),
              onSecondary: const Color(0xff843c0c),
              error: Colors.red.shade400,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xffff0000),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
            navigationBarTheme: NavigationBarThemeData(
                backgroundColor: const Color(0xffff0000),
                labelTextStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white)),
                iconTheme: MaterialStateProperty.resolveWith((states) {
                  if (states.isEmpty) {
                    return const IconThemeData(color: Colors.white);
                  }
                })),
            tabBarTheme: const TabBarTheme(
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                    color: Color(0xff843c0c),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                indicatorColor: Color(0xff843c0c)),
            primaryColor: const Color(0xff843c0c),
            useMaterial3: true),
        home: const SplashScreen());
  }
}
