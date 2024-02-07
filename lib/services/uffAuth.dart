import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_for_you/models/user_model.dart';
import 'package:food_for_you/widgets/alert_box.dart';

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

  Future createEmailAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final auth = FirebaseAuth.instance;

    if (email == "" || !email.contains(".com")) {
      showAlerts(context: context, content: const Text("Invalid email"));
      throw "Invalid Email";
    } else if (password == "" || password.length <= 8) {
      showAlerts(
          context: context,
          content: const Text("Password should be atleast 8 characters"));
      throw "Invalid Password";
    } else {
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
