import 'package:inkrement/auth/domain/user.dart';

abstract class AuthService {
  Future<void> signInAnonymously();
  User? getUser();
}
