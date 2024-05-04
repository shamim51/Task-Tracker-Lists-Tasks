import 'package:another_stepper/dto/stepper_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_tracker/services/utils/get_user_id.dart';
import 'dart:async';


class FetchTaskFromFireStore {


  static Future<List<StepperData>> getTasks() async {

    List<StepperData> stepperData = [];
    try {
      String userId="user1";
      String userName = " ";
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
         userId = user.uid;
      }
      print("================================================");
      print("userId:" );
      print(userId);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();


      // Populate stepperData list with the fetched tasks
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String title = data['title'];
        String subtitle = data['subtitle'];
        Widget iconWidget;

        if (subtitle == 'not done yet') {
          iconWidget = Icon(
            Icons.task,
            color: Colors.white,
            size: 20,
          );
          print("i am in if");

        } else if (subtitle == 'in progress') {
          iconWidget = Stack(
            children: [
              Center(child: Icon(Icons.task, color: Colors.grey, size: 20)),
              Center(child: SpinKitSpinningLines(color: Colors.white, size: 40,)),
            ],
          );
          print("i am in else if");
        }
        else if(subtitle == 'done'){
          iconWidget = Icon(
            Icons.task_alt,
            color: Colors.white,
            size: 20,
          );
        }
        else {
          iconWidget = Container();
          print("i am in else");
        }

        // Add task data to stepperData list
        stepperData.add(
          StepperData(
            title: StepperText(
              title,
              textStyle: const TextStyle(color: Colors.grey),
            ),
            subtitle: StepperText(subtitle),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: iconWidget,
            ),
          ),
        );
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }

    stepperData.sort((a, b) {
      if (a.subtitle?.text == 'done' && b.subtitle?.text != 'done') {
        return -1; // a comes before b
      } else if (a.subtitle?.text != 'done' && b.subtitle?.text == 'done') {
        return 1; // b comes before a
      } else {
        return 0; // relative order remains unchanged
      }
    });


    return stepperData;
  }

  /*
  static Stream<List<StepperData>> getTasksStream() {
    try {
      String userId = "user1"; // Default user ID
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
      return FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String title = data['title'];
          String subtitle = data['subtitle'];
          Widget iconWidget;
          // Handle iconWidget creation based on subtitle
          if (subtitle == 'not done yet') {
            iconWidget = Icon(
              Icons.task,
              color: Colors.white,
              size: 20,
            );
            print("i am in if");

          } else if (subtitle == 'in progress') {
            iconWidget = Stack(
              children: [
                Center(child: Icon(Icons.task, color: Colors.grey, size: 20)),
                Center(child: SpinKitSpinningLines(color: Colors.white, size: 40,)),
              ],
            );
            print("i am in else if");
          }
          else if(subtitle == 'done'){
            iconWidget = Icon(
              Icons.task_alt,
              color: Colors.white,
              size: 20,
            );
          }
          else {
            iconWidget = Container();
            print("i am in else");
          }
          // ...
          return StepperData(
            title: StepperText(
              title,
              textStyle: const TextStyle(color: Colors.grey),
            ),
            subtitle: StepperText(subtitle),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: iconWidget,
            ),
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching tasks: $e');
      return Stream.value([]); // Return an empty stream in case of error
    }
  }*/

  /*
  static Future<List<StepperData>> getTasks() async {
    try {
    String userId = "user1"; // Default user ID
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }

  StreamController<List<StepperData>> controller = StreamController();

  FirebaseFirestore.instance
      .collection('tasks')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .listen((QuerySnapshot snapshot) {
        List<StepperData> stepperData = [];
        snapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String title = data['title'];
        String subtitle = data['subtitle'];
        Widget iconWidget;
        // Handle iconWidget creation based on subtitle
        if (subtitle == 'not done yet') {
          iconWidget = Icon(
            Icons.task,
            color: Colors.white,
            size: 20,
          );
          print("i am in if");

        } else if (subtitle == 'in progress') {
          iconWidget = Stack(
            children: [
              Center(child: Icon(Icons.task, color: Colors.grey, size: 20)),
              Center(child: SpinKitSpinningLines(color: Colors.white, size: 40,)),
            ],
          );
          print("i am in else if");
        }
        else if(subtitle == 'done'){
          iconWidget = Icon(
            Icons.task_alt,
            color: Colors.white,
            size: 20,
          );
        }
        else {
          iconWidget = Container();
          print("i am in else");
        }
        // ...
        stepperData.add(
          StepperData(
            title: StepperText(
               title,
                textStyle: const TextStyle(color: Colors.grey),
            ),
            subtitle: StepperText(subtitle),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: iconWidget,
            ),
        ),
        );
        });
        controller.add(stepperData); // Add the fetched data to the stream
        controller.close(); // Close the stream when done
        });

        // Create a completer to wait for the stream to complete
        Completer<List<StepperData>> completer = Completer();

        // Listen for the completion of the stream and resolve the completer
        controller.stream.listen((List<StepperData> data) {
        completer.complete(data);
        }, onError: (error) {
        completer.completeError(error);
        });

        // Return the future from the completer
  return completer.future;

  } catch (e) {
  print('Error fetching tasks: $e');
  return []; // Return an empty list in case of error
  }
  }*/





  /*static Stream<List<StepperData>> getTasksStream() {
    return FirebaseFirestore.instance.collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final title = doc['title'] as String; // Replace 'title' with your field name for title
      final subtitle = doc['subtitle'] as String; // Replace 'subtitle' with your field name for subtitle
      return StepperData(
        title: StepperText(title),
        subtitle: StepperText(subtitle),
        // Add other fields as needed
      );
    }).toList());
  }*/
}
