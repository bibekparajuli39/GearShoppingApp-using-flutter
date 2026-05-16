import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressprovider = StreamProvider.family<String, String>((ref, userId) {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return db.collection('users').doc(userId).snapshots().map((doc) {
    final data = doc.data();

    if (doc.exists && data != null) {
      final address = data['address'] as String?;
      if (address != null) {
        return address;
      } else {
        return 'No address found';
      }
    } else {
      return 'No address found';
    }
  });
});
