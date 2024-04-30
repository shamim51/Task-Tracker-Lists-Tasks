import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

class TimelineV2 extends StatefulWidget {
  const TimelineV2({super.key});

  @override
  State<TimelineV2> createState() => _TimelineV2State();
}

class _TimelineV2State extends State<TimelineV2> {
  List<StepperData> stepperData = [
    // StepperData(
    //     title: StepperText(
    //       "Order Placed",
    //       textStyle: const TextStyle(
    //         color: Colors.grey,
    //       ),
    //     ),
    //     subtitle: StepperText("Your order has been placed"),
    //     iconWidget: Container(
    //       padding: const EdgeInsets.all(8),
    //       decoration: const BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //     )),
    // StepperData(
    //     title: StepperText("Preparing"),
    //     subtitle: StepperText("Your order is being prepared"),
    //     iconWidget: Container(
    //       padding: const EdgeInsets.all(8),
    //       decoration: const BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //       child: const Icon(Icons.looks_two, color: Colors.white),
    //     )),
    // StepperData(
    //     title: StepperText("On the way"),
    //     subtitle: StepperText(
    //         "Our delivery executive is on the way to deliver your item"),
    //     iconWidget: Container(
    //       padding: const EdgeInsets.all(8),
    //       decoration: const BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //       child: const Icon(Icons.looks_3, color: Colors.white),
    //     )),

    // StepperData(
    //     title: StepperText("Delivered",
    //         textStyle: const TextStyle(color: Colors.grey)),
    //     iconWidget: Container(
    //       padding: const EdgeInsets.all(8),
    //       decoration: const BoxDecoration(
    //           color: Colors.redAccent,
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //     )),
    StepperData(
      title: StepperText(
        "Order Placed",
        textStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      subtitle: StepperText("Your order has been placed"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Preparing"),
      subtitle: StepperText("Your order is being prepared"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("On the way"),
      subtitle: StepperText(
          "Our delivery executive is on the way to deliver your item"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Delivered",
        textStyle: const TextStyle(color: Colors.grey),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 40,
                iconHeight: 40,
                activeBarColor: Colors.green,
                inActiveBarColor: Colors.grey,
                inverted: true,
                verticalGap: 30,
                activeIndex: 1,
                barThickness: 8,
              ),
            ),
          ],
        ),
      );
  }
}