import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login.dart'; // Import FirebaseAuth if not already imported

// Function to handle logout
Future<void> signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // Navigate back to login screen or any other screen as needed
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your login screen
        (route) => false,
  );
}
