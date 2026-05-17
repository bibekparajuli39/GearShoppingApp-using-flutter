import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StreamProvider.family<QuerySnapshot, String>((
  ref,
  String userId,
) {
  final db = FirebaseFirestore.instance;
  return db
      .collection('users')
      .doc(userId)
      .collection('orders')
      .orderBy('createdAt', descending: true)
      .snapshots();
});
