import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/firebase_options.dart';
import 'package:food_for_you/screens/dashboard/layout.dart';
import 'package:food_for_you/screens/login_signup/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkLogin() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("login");

    if (userId != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardLayout()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      checkLogin();
      timer.cancel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
      },
    );
  }
}
