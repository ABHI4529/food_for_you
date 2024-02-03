import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        return response;
      } catch (e) {
        // ignore: use_build_context_synchronously
        showAlerts(context: context, content: Text("Something went wrong $e"));
        throw "something went wrong";
      }
    }
  }
}
