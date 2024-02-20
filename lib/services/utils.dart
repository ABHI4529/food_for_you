import 'package:shared_preferences/shared_preferences.dart';

Future saveCreds(String creds) async {
  final preferences = await SharedPreferences.getInstance();

  preferences.setString("login", "creds");
}

Future getUserId() async {
  final preferences = await SharedPreferences.getInstance();
  final uId = preferences.get("login");
  return uId;
}
