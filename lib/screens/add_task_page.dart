import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/services/deleteTaskFromFireStore.dart';
import 'package:task_tracker/services/save_task_to_firebase.dart';

import '../models/task_model.dart';

// class AddTaskDialog extends StatefulWidget {
//   @override
//   _AddTaskDialogState createState() => _AddTaskDialogState();
// }
//
// class _AddTaskDialogState extends State<AddTaskDialog> {
//   final TextEditingController _titleController = TextEditingController();
//
//   User? user = FirebaseAuth.instance.currentUser;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Task'),
//       content: TextField(
//         controller: _titleController,
//         decoration: InputDecoration(labelText: 'Task Title'),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Add your logic to save the task
//             String title = _titleController.text;
//             // Here you can save the task or perform any other action
//             print('Task Title: $title');
//             Task task = Task(title: title, subtitle: 'not done yet');
//
//             addTaskToFirestore(user!.uid, task);
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
//   }
// }
// class AddTaskDialog extends StatefulWidget {
//   @override
//   _AddTaskDialogState createState() => _AddTaskDialogState();
// }
//
// class _AddTaskDialogState extends State<AddTaskDialog> {
//   final TextEditingController _titleController = TextEditingController();
//
//   User? user = FirebaseAuth.instance.currentUser;
//
//   bool _isDeleteMode = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(_isDeleteMode ? 'Delete Task' : 'Add Task'),
//       content: _isDeleteMode
//           ? Text('Are you sure you want to delete this task?')
//           : TextField(
//         controller: _titleController,
//         decoration: InputDecoration(labelText: 'Task Title'),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_isDeleteMode) {
//               // Implement logic to delete the task
//               deleteTaskFromFirestore(user!.uid);
//               Navigator.of(context).pop(); // Close the dialog
//             } else {
//               // Add your logic to save the task
//               String title = _titleController.text;
//               // Here you can save the task or perform any other action
//               print('Task Title: $title');
//               Task task = Task(title: title, subtitle: 'not done yet');
//
//               addTaskToFirestore(user!.uid, task);
//               Navigator.of(context).pop(); // Close the dialog
//             }
//           },
//           child: Text(_isDeleteMode ? 'Delete' : 'Save'),
//         ),
//       ],
//       actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
//       contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  bool _isDeleteMode = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: TextField(
        controller: _titleController,
        decoration: InputDecoration(labelText: 'Task Title'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Add your logic to save the task
            String title = _titleController.text;
            // Here you can save the task or perform any other action
            print('Task Title: $title');
            Task task = Task(title: title, subtitle: 'not done yet');

            addTaskToFirestore(user!.uid, task);
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            // Delete the task based on the entered title
            String title = _titleController.text;
            DeleteTask().deleteTaskFromFirestore(user!.uid, title);
            Navigator.of(context).pop(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(
             backgroundColor : Colors.redAccent,
            foregroundColor: Colors.white// Set button color to red
          ),
          child: Text('Delete'),
        ),
      ],
    );
  }
}




