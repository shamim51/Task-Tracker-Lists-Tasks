import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_tracker/screens/dashboard.dart';
import 'package:task_tracker/screens/login.dart';
import 'package:task_tracker/screens/signUpPage.dart';
import 'package:task_tracker/widgets/test_timeline.dart';
import 'package:task_tracker/widgets/timeline.dart';
import 'package:task_tracker/widgets/timelineV2.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Adding this line for fixing the app on portrait mode only.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Adding this line for disabling the system overlay color on top. so that our app scaffold color covers the hole screen
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const Dashboard(),
     home: Scaffold(
         drawer: Drawer(),
         body:StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context, AsyncSnapshot snapshot){
             if(snapshot.hasData )
             {
               return const Dashboard();
             }
             else
             {
               return const SignUp();
             }
           },
         )
     ),
    );
  }
}



