import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gearapp/admin/service/order_admin_service.dart';

final orderSerProvider = Provider((ref) {
  return OrderService();
});

final adminorderProvider = StreamProvider<QuerySnapshot?>((ref) {
  final snapshot = ref.watch(orderSerProvider);
  return snapshot.getAllorder();
});
final loadingOrdersProvider = StateProvider<Set<String>>((ref) => {});
