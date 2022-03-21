import '../../auth/data/firebase_auth_service.dart';
import '../../auth/domain/auth_service.dart';
import '../../counter/data/firestore_counter_service.dart';
import '../../counter/domain/counter_service.dart';

AuthService authService = FirebaseAuthService();
CounterService counterService = FirestoreCounterService(authService);
