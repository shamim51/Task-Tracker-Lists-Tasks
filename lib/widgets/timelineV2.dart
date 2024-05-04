import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lottie/lottie.dart';
import 'package:task_tracker/services/fetch_task_from_firebase.dart';


class TimelineV2 extends StatefulWidget {
  const TimelineV2({super.key});

  @override
  State<TimelineV2> createState() => _TimelineV2State();
}

class _TimelineV2State extends State<TimelineV2> {

  int lastDone = -1;

  late StreamSubscription<List<StepperData>> _taskSubscription;

  List<StepperData> stepperData = [];

  //int last_done = 0;

  @override
  void initState() {
    super.initState();
    // Call getTasks to fetch tasks from Firestore
    //_taskSubscription = listenToTasks();
    _fetchTasks();
    _setUpFirestoreListener();
  }


  Future<void> _fetchTasks() async {
    List<StepperData> tasks = await FetchTaskFromFireStore.getTasks();
    setState(() {
      stepperData = tasks;
      lastDone = getLastDoneTaskIndex(stepperData);

      StepperData firstNotDoneTask = stepperData[lastDone+1];

      // Modify its icon widget
      StepperData modifiedTask = StepperData(
        title: firstNotDoneTask.title,
        subtitle: firstNotDoneTask.subtitle,
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Stack(
            children: [
              Center(child: Icon(Icons.task, color: Colors.grey, size: 20)),
              Center(child: SpinKitSpinningLines(color: Colors.white, size: 40)),
            ],
          ),
        ),
      );

      stepperData[lastDone+1] = modifiedTask;

    });
  }

  int getLastDoneTaskIndex(List<StepperData> stepperData) {
    for (int i = stepperData.length - 1; i >= 0; i--) {
      if (stepperData[i].subtitle?.text == 'done') {
        return i;
      }
    }
    // If no "done" task found, return -1
    return -1;
  }

  //int last_done = getLastDoneTaskIndex(stepperData);

  // FirebaseFirestore.instance.collection('your_collection').snapshots().listen((snapshot) {
  //   _fetchTasks();
  // }



  /*
  void _fetchTasks() {
    FetchTaskFromFireStore.getTasks().then((List<StepperData> tasks) {
      setState(() {
        stepperData = tasks;
      });
    }).catchError((error) {
      // Handle error
      print('Error fetching tasks: $error');
    });
  }*/


  @override
  void dispose() {
    // Cancel the stream subscription when the widget is disposed
    _taskSubscription.cancel();
    super.dispose();
  }

  // Function to listen to changes in Firestore and update the UI
  // StreamSubscription<List<StepperData>> listenToTasks() {
  //   return FetchTaskFromFireStore.getTasksStream().listen((tasks) {
  //     setState(() {
  //       stepperData = tasks;
  //     });
  //   });
  // }

  void _setUpFirestoreListener() {
    FirebaseFirestore.instance.collection('tasks').snapshots().listen((snapshot) {
      //_fetchTasks(); // Fetch tasks whenever there's a change in Firestore
      _fetchTasks();
      print("-----------------------------------------------------------------------------");
      print("Something has been changed");
      print("-----------------------------------------------------------------------------");
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110, // Fixed height for the icon row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitPouringHourGlass(
                  color: Colors.black,
                  size: 100,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 100),
              child: ListView(
                children: <Widget>[
                  // Your list items here
                  AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.vertical,
                    iconWidth: 40,
                    iconHeight: 40,
                    activeBarColor: Colors.green,
                    inActiveBarColor: Colors.grey,
                    inverted: false,
                    verticalGap: 30,
                    activeIndex: lastDone,
                    barThickness: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
