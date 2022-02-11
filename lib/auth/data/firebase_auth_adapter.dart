import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_adapter.dart';

class FirebaseAuthAdapter implements AuthAdapter {
  @override
  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
