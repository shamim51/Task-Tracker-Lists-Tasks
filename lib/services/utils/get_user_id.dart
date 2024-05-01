import 'package:firebase_auth/firebase_auth.dart';

// Function to get current user's ID
String getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    // Handle scenario where user is not logged in
    return ''; // or you can throw an exception or return null based on your app's logic
  }
}