import 'package:flutter/material.dart';
import 'package:vidlearn/pages/home-page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Spacer(),
                Text(
                  'Reset your password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Enter your email address or phone number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Spacer(),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Sign In?'),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigation
                      Navigator.of(context).pushReplacementNamed(
                          '/main'); //"pushReplacementNamed" to avoid go back to Signup page
                      // print('Signup button is clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Reset'),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
