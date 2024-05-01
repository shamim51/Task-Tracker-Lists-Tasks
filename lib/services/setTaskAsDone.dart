import 'package:cloud_firestore/cloud_firestore.dart';

class SetTaskAsDone{
  static Future<void> setTaskSubtitleToDone(String userId, String title) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .where('title', isEqualTo: title)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update all documents that match the query
        querySnapshot.docs.forEach((doc) {
          doc.reference.update({'subtitle': 'done'});
        });
      } else {
        print('No matching tasks found');
      }
    } catch (error) {
      print('Error setting task subtitle to done: $error');
    }
  }
}
