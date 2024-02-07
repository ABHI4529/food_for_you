import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/models/user_model.dart';
import 'package:food_for_you/screens/dashboard/layout.dart';
import 'package:food_for_you/services/uffAuth.dart';
import 'package:food_for_you/services/utils.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final auth = Auth();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (contextr) =>
            const Center(child: CircularProgressIndicator()));

    final resp = auth.createEmailAccount(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);

    Navigator.pop(context);
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: CupertinoTextField(
              controller: _userNameController,
              placeholder: "Full Name",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.only(top: 5),
            child: CupertinoTextField(
              controller: _emailController,
              placeholder: "Email address",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CupertinoTextField(
              controller: _passwordController,
              placeholder: "Password",
            ),
          ),
          const Spacer(),
          FilledButton(
              onPressed: () {
                signUp().then((value) async {
                  if (value is User) {
                    User creds = value;
                    final user = UserModel(
                        userEmail: creds.email,
                        userId: creds.uid,
                        createdTime: DateTime.now(),
                        userName: _userNameController.text);

                    auth
                        .saveUserToDatabase(user: user, context: context)
                        .then((value) {
                      saveCreds(user.userId.toString()).then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardLayout()));
                      });
                    });
                  }
                });
              },
              child: const Text("Create Account")),
          const Spacer()
        ],
      ),
    );
  }
}
