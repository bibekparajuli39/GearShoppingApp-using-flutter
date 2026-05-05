import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authprovider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);

class AuthService {
  final FirebaseAuth auth;
  AuthService(this.auth);

  Future<void> signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> reset(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
});
