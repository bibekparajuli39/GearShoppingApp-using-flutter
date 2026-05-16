import 'package:cloud_firestore/cloud_firestore.dart';

class AddressService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // set the address of user in firestore
  Future<void> setAddress(String userId, String address) async {
    final ref = await db.collection('users').doc(userId).set({
      'address': address,
    }, SetOptions(merge: true));

    return ref;
  }

  Future<void> updateAddress(String userId) async {
    final ref = await db.collection('users').doc(userId).update({
      'address': '',
    });
    return ref;
  }
}
