import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

// Future<void> addTaskToFirestore(String userId, Task task) async {
//   try {
//     await FirebaseFirestore.instance.collection('tasks').add({
//       'title': task.title,
//       'subtitle': task.subtitle,
//       'userId': userId,
//     });
//   } catch (e) {
//     print('Error adding task: $e');
//   }
// }

Future<void> addTaskToFirestore(String userId, Task task) async {
  try {
    // Get a reference to the tasks collection
    final tasksCollection = FirebaseFirestore.instance.collection('tasks');

    // Get the latest task ID
    final latestTask = await tasksCollection.orderBy('taskId', descending: true).limit(1).get();
    int newTaskId = 1; // Default to 1 if no tasks exist yet

    // If there are existing tasks, set the new ID to the next number
    if (latestTask.docs.isNotEmpty) {
      newTaskId = latestTask.docs.first.data()['taskId'] + 1;
    }

    // Add the new task with the generated ID
    await tasksCollection.add({
      'taskId': newTaskId,
      'tempTaskId': newTaskId,
      'title': task.title,
      'subtitle': task.subtitle,
      'userId': userId,
    });
  } catch (e) {
    print('Error adding task: $e');
  }
}
