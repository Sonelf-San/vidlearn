import 'package:flutter/material.dart';
import 'package:vidlearn/pages/home-page.dart';
import 'package:vidlearn/pages/login-page.dart';
import 'package:vidlearn/pages/main_page.dart';
import 'package:vidlearn/pages/forgot_password.dart';
import 'package:vidlearn/styles/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Urbanist',
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.dark,
      ),
      // Making routes
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
