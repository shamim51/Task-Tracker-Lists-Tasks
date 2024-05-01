import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
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

  late StreamSubscription<List<StepperData>> _taskSubscription;

  List<StepperData> stepperData = [];

  @override
  void initState() {
    super.initState();
    // Call getTasks to fetch tasks from Firestore
    _taskSubscription = listenToTasks();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    List<StepperData> tasks = await FetchTaskFromFireStore.getTasks();
    setState(() {
      stepperData = tasks;
    });
  }
  @override
  void dispose() {
    // Cancel the stream subscription when the widget is disposed
    _taskSubscription.cancel();
    super.dispose();
  }

  // Function to listen to changes in Firestore and update the UI
  StreamSubscription<List<StepperData>> listenToTasks() {
    return FetchTaskFromFireStore.getTasksStream().listen((tasks) {
      setState(() {
        stepperData = tasks;
      });
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
                    activeIndex: 0,
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
