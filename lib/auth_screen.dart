import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
            if (userCredential.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    isDarkMode: false, // Set the initial dark mode state
                    onThemeChanged: (bool value) {
                      // Handle theme change
                      print('Theme changed: $value');
                    },
                  ),
                ),
              );
            }
          },
          child: Text('Sign In'),
        ),
      ),
    );
  }
}
