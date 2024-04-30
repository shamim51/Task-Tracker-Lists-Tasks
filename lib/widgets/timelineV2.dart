import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';


class TimelineV2 extends StatefulWidget {
  const TimelineV2({super.key});

  @override
  State<TimelineV2> createState() => _TimelineV2State();
}

class _TimelineV2State extends State<TimelineV2> {
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Task 1",
          // textStyle: const TextStyle(
          //   color: Colors.grey,
          // ),
        ),
        //subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_one, color: Colors.white,),
        )),
    StepperData(
        title: StepperText("Task 2"),
        //subtitle: StepperText(" "),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Task 3"),
        //subtitle: StepperText(" "),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),

    StepperData(
        title: StepperText("Task 4",
            //textStyle: const TextStyle(color: Colors.grey)
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_4, color: Colors.white),
        )),

  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(

          children: [
           Lottie.asset(
             "animations/6.json",
               height: 200,
               width: 300,
               repeat: true,
               fit: BoxFit.cover,
           ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 100),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 40,
                iconHeight: 40,
                activeBarColor: Colors.green,
                inActiveBarColor: Colors.grey,
                inverted: false,
                verticalGap: 30,
                activeIndex: 2,
                barThickness: 8,
              ),
            ),
          ],
        ),
      );
  }
}
