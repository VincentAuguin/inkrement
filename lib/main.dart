import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkrement/auth/data/firebase_auth_service.dart';
import 'package:inkrement/auth/domain/auth_service.dart';
import 'package:inkrement/counter/domain/counter_service.dart';
import 'package:inkrement/home/presentation/home_page.dart';

import 'counter/data/firestore_counter_service.dart';
import 'shared/presentation/theme.dart';

void main() {
  AuthService authService = FirebaseAuthService();
  CounterService counterService = FirestoreCounterService(authService);
  runApp(InkrementApp(
    authService: authService,
    counterService: counterService,
  ));
}

class InkrementApp extends StatelessWidget {
  const InkrementApp(
      {Key? key, required this.authService, required this.counterService})
      : super(key: key);

  final AuthService authService;

  final CounterService counterService;

  Future<void> _init() async {
    await Firebase.initializeApp();
    await authService.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final RouteObserver<PageRoute> routeObserver = RouteObserver();
    return MaterialApp(
      title: 'Inkrement',
      theme: getTheme(),
      home: FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage(
              counterService: counterService,
              routeObserver: routeObserver,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("Something went wrong with app init");
          }
        },
      ),
      navigatorObservers: [routeObserver],
    );
  }
}
