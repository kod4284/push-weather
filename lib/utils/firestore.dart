import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> appendToArray(dynamic element) async {
    _firestore.collection('push_weather').doc('feedback').update({
      'contents': FieldValue.arrayUnion([element]),
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}