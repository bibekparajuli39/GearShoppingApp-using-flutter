import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/legacy.dart';

class LoginService extends StateNotifier<bool> {
  LoginService() : super(false);

  Future<String> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        state = true;
        return "success";
      } else {
        state = false;
        return "Incorrect username or password";
      }
    } catch (e) {
      state = false;
      return "Something went wrong";
    }
  }

  Future<void> logOut() async {
    state = false;
  }
}
