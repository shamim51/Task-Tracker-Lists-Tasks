

// import 'package:another_stepper/another_stepper.dart';
// import 'package:another_stepper/dto/stepper_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   int activeIndex = 0;

//   @override
//   Widget build(BuildContext context) {

    

//     void changeStepperIndex(int val){
//       setState(() {
//               activeIndex = val;
//       });
//     }

//     List stepperData = [
//       {
//         "title":"Order Placed",
//         "subTitle":"Your order has been placed"
//       },
//       {
//         "title":"Preparing",
//         "subTitle":"Your order is being prepared"
//       },
//       {
//         "title":"On the way",
//         "subTitle":"Our delivery executive is on the way to deliver your item"
//       },
//       {
//         "title":"Delivered",
//         "subTitle":""
//       }
//     ];


//     return Container(
//       child: Center(
//         child: Column(
//           children: [
//             AnotherStepper(
//                     // this is removed 
                    
//                     // dotWidget: Container(
//                     //   padding: EdgeInsets.all(8),
//                     //   decoration: BoxDecoration(
//                     //       color: Colors.red,
//                     //       borderRadius: BorderRadius.all(Radius.circular(30))),
//                     //   child: Icon(Icons.fastfood, color: Colors.white),
//                     // ),                      
//               stepperList: List<StepperData>.generate
//               (stepperData.length,(i) => StepperData(iconWidget: Container(width:30, height:30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
//               color:i ==  activeIndex || i < activeIndex ? Colors.green : Colors.grey ,
//               )),
//               title: StepperText(
//                 stepperData[i]["title"],
//                 textStyle:  TextStyle(
//                   color: i ==  activeIndex ? Colors.black : Colors.grey,
//                 ),
//               ),
//               subtitle: StepperText(stepperData[i]["subTitle"], textStyle:  TextStyle(
//                   color: i ==  activeIndex ? Colors.black : Colors.grey,
//                 ),),
//               ),
//               ),
//                     stepperDirection: Axis.vertical,
//                     //gap: 20,
//                     iconWidth: 24,
//                     iconHeight: 24,

//                     activeBarColor: Colors.green,
//                     inActiveBarColor: Colors.grey,
//                     activeIndex: activeIndex,
//                     barThickness: 8,
//                   ),
//                   TextButton(child: Text('change step 1'), onPressed: (){
//                     changeStepperIndex(0);
//                   },),
                 
//           ],    )));
//   }
// }

import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;

  void changeStepperIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  List<Map<String, String>> stepperData = [
    {"title": "Order Placed", "subTitle": "Your order has been placed"},
    {"title": "Preparing", "subTitle": "Your order is being prepared"},
    {
      "title": "On the way",
      "subTitle": "Our delivery executive is on the way to deliver your item"
    },
    {"title": "Delivered", "subTitle": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnotherStepper(
              stepperList: List<StepperData>.generate(
                stepperData.length,
                (index) => StepperData(
                  iconWidget: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: index <= activeIndex ? Colors.green : Colors.grey,
                    ),
                  ),
                  title: StepperText(
                    stepperData[index]["title"]!,
                    textStyle: TextStyle(
                      color: index == activeIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                  subtitle: StepperText(
                    stepperData[index]["subTitle"]!,
                    textStyle: TextStyle(
                      color: index == activeIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              stepperDirection: Axis.vertical,
              iconWidth: 24,
              iconHeight: 24,
              activeBarColor: Colors.green,
              inActiveBarColor: Colors.grey,
              activeIndex: activeIndex,
              barThickness: 8,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeStepperIndex(0),
                  child: const Text('Step 1'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => changeStepperIndex(1),
                  child: const Text('Step 2'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => changeStepperIndex(2),
                  child: const Text('Step 3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
