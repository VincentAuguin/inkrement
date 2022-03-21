import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkrement/shared/data/services.dart';
import 'package:inkrement/shared/presentation/routes.dart';

import 'shared/presentation/theme.dart';

void main() {
  runApp(const InkrementApp());
}

class InkrementApp extends StatelessWidget {
  const InkrementApp({Key? key}) : super(key: key);

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
    _init();
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Inkrement',
            theme: getTheme(),
            initialRoute: '/',
            routes: routes,
            navigatorObservers: [routeObserver],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
