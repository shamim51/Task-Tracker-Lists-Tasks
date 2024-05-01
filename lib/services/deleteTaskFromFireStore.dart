import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTask {
   void deleteTaskFromFirestore(String userId, String title) {
    FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('title', isEqualTo: title)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print('Error deleting task: $error');
    });
  }
}