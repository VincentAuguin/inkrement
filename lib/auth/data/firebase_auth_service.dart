import 'package:firebase_auth/firebase_auth.dart';
import 'package:inkrement/auth/domain/user.dart' as domain_user;

import '../domain/auth_service.dart';

class FirebaseAuthService implements AuthService {
  @override
  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  domain_user.User? getUser() {
    return _toDomainUser(FirebaseAuth.instance.currentUser);
  }

  domain_user.User? _toDomainUser(User? user) {
    if (user != null) {
      return domain_user.User(user.uid);
    } else {
      return null;
    }
  }
}
