import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/firebase_options.dart';
import 'package:food_for_you/screens/login_signup/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          return Login();
        } else {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
      },
    );
  }
}
