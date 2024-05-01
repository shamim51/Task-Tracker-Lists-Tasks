import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

Future<void> addTaskToFirestore(String userId, Task task) async {
  try {
    await FirebaseFirestore.instance.collection('tasks').add({
      'title': task.title,
      'subtitle': task.subtitle,
      'userId': userId,
    });
  } catch (e) {
    print('Error adding task: $e');
  }
}