import 'package:flutter/material.dart';
import 'package:vidlearn/pages/dashboard.dart';
import 'package:vidlearn/pages/home-page.dart';
import 'package:vidlearn/pages/login-page.dart';
import 'package:vidlearn/pages/main_page.dart';
import 'package:vidlearn/pages/forgot_password.dart';
import 'package:vidlearn/styles/app_colors.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
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
        '/dashboard': (context) => Dashboard(),
        // '/main':(context) => MainPage(),
      },
    );
  }
}
