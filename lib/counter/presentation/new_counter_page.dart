import 'package:flutter/material.dart';
import 'package:inkrement/counter/presentation/new_counter_form.dart';

class NewCounterPage extends StatelessWidget {
  const NewCounterPage({Key? key}) : super(key: key);

  static const String route = '/new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New counter"),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: NewCounterForm()),
          ),
        ));
  }
}
