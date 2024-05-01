import 'package:another_stepper/dto/stepper_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_tracker/services/utils/get_user_id.dart';

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

    return stepperData;
  }
  static Stream<List<StepperData>> getTasksStream() {
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
  }
}
