import 'package:flutter/material.dart';
import 'package:task_tracker/services/logout.dart';
import 'package:task_tracker/widgets/timelineV2.dart';

import 'add_task_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: Text("My Tasks"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              signOut(context);
            },
          )
        ],
      ),

      body: TimelineV2(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTaskDialog();
            },
          );
        },
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        child: const Icon(Icons.settings),
      ),
    );
  }
}
