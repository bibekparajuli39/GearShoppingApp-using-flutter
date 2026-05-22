import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllorder() {
    return db.collection('orders').snapshots();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String userId,
    required String status,
  }) async {
    await Future.wait([
      db.collection('orders').doc(orderId).update({'status': status}),
      db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({'status': status}),
    ]);
  }
}
