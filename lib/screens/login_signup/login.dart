import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_you/screens/dashboard/layout.dart';
import 'package:food_for_you/screens/login_signup/signup.dart';
import 'package:food_for_you/services/uffAuth.dart';
import 'package:food_for_you/services/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 2,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(50)),
                child: Image.asset(
                  "assets/login_screen.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: height / 2,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.7,
                      child: SizedBox(
                        height: 350,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(50)),
                          child: Image.asset(
                            "assets/login_screen.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [
                            0,
                            0.3,
                            0.7
                          ],
                              colors: [
                            Colors.transparent,
                            Colors.white.withAlpha(150),
                            Colors.white
                          ])),
                      child: Column(children: [
                        TabBar(controller: _tabController, tabs: const [
                          Tab(
                            child: Text("Login"),
                          ),
                          Tab(
                            child: Text("SignUp"),
                          )
                        ]),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: const [LoginForm(), SignUpForm()],
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final auth = Auth();

  Future login() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    final resp = auth.loginWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: CupertinoTextField(
              placeholder: "Email address",
              controller: _emailController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CupertinoTextField(
              placeholder: "Password",
              obscureText: isObscure,
              controller: _passwordController,
              suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(isObscure
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash),
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: FilledButton(
              onPressed: () {
                login().then((value) {
                  if (value is User) {
                    saveCreds(value.uid).then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardLayout()));
                    });
                  }
                });
              },
              child: const Text("Login"),
            ),
          ),
          const Center(
            child: Text("or"),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 15,
                      )),
                  OutlinedButton(
                      onPressed: () {},
                      child: const FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 15,
                      )),
                  OutlinedButton(
                      onPressed: () {},
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 15,
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
