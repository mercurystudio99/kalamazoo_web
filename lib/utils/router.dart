import 'package:flutter/material.dart';
import 'package:bestlocaleats/pages/homepage.dart';
import 'package:bestlocaleats/pages/login.dart';

class NavigationRouter {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void switchToHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  static void switchToLoginPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
