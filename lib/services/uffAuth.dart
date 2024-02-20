import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/models/user_model.dart';
import 'package:food_for_you/screens/login_signup/login.dart';
import 'package:food_for_you/widgets/alert_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final auth = FirebaseAuth.instance;

    if (email == "" || !email.contains(".com")) {
      showAlerts(context: context, content: const Text("Invalid email"));
      throw "Invalid Email";
    } else {
      try {
        final response = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        return response.user;
      } catch (e) {
        // ignore: use_build_context_synchronously
        showAlerts(context: context, content: Text("Something went wrong $e"));
        throw "something went wrong";
      }
    }
  }

  Future logoutAccount(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  Future createEmailAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final auth = FirebaseAuth.instance;

    try {
      final response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return response.user;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAlerts(context: context, content: Text("Something went wrong $e"));
      throw "something went wrong";
    }
  }

  Future saveUserToDatabase(
      {required UserModel user, required BuildContext context}) async {
    final database = FirebaseFirestore.instance.collection("users");
    try {
      await database.doc(user.userId).set(user.toJson());
    } catch (e) {
      showAlerts(context: context, content: Text("Something went wrong $e"));
      throw "something went wrong";
    }
  }
}
