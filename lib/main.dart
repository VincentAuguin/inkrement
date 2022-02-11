import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkrement/auth/domain/auth_adapter.dart';
import 'package:inkrement/auth/data/firebase_auth_adapter.dart';
import 'package:inkrement/counter/domain/counter_adapter.dart';
import 'package:inkrement/home/presentation/home_page.dart';

import 'counter/data/firestore_counter_adapter.dart';
import 'shared/theme.dart';

void main() {
  runApp(InkrementApp(
    authAdapter: FirebaseAuthAdapter(),
    counterAdapter: FirestoreCounterAdapter(),
  ));
}

class InkrementApp extends StatelessWidget {
  const InkrementApp(
      {Key? key, required this.authAdapter, required this.counterAdapter})
      : super(key: key);

  final AuthAdapter authAdapter;

  final CounterAdapter counterAdapter;

  Future<void> _init() async {
    await Firebase.initializeApp();
    await authAdapter.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: getTheme(),
        home: Scaffold(
          body: SafeArea(
            child: FutureBuilder(
              future: _init(),
              builder: (context, snapshot) {
                if (!snapshot.hasError) {
                  return HomePage(counterAdapter: counterAdapter);
                } else {
                  return const Text("Something went wrong with app init");
                }
              },
            ),
          ),
        ));
  }
}
