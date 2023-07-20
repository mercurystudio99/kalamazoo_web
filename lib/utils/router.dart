import 'package:flutter/material.dart';
import 'package:bestlocaleats/pages/homepage.dart';
import 'package:bestlocaleats/pages/login.dart';
import 'package:bestlocaleats/pages/signup.dart';
import 'package:bestlocaleats/pages/forgot.dart';
import 'package:bestlocaleats/pages/otp.dart';
import 'package:bestlocaleats/pages/reset.dart';
import 'package:bestlocaleats/pages/allrestaurantpage.dart';
import 'package:bestlocaleats/pages/about.dart';
import 'package:bestlocaleats/pages/favorite.dart';
import 'package:bestlocaleats/pages/notification.dart';
import 'package:bestlocaleats/pages/contact.dart';

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

  static void switchToSignupPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupPage()));
  }

  static void switchToForgotPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ForgotPage()));
  }

  static void switchToOTPPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OTPPage()));
  }

  static void switchToResetPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ResetPage()));
  }

  static void switchToAllRestaurantPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AllRestaurantPage()));
  }

  static void switchToAboutPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutPage()));
  }

  static void switchToFavoritePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FavoritePage()));
  }

  static void switchToNotificationPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationPage()));
  }

  static void switchToContactPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ContactPage()));
  }
}
