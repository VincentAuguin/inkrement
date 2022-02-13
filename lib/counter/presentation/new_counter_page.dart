import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_service.dart';
import 'package:inkrement/counter/presentation/new_counter_form.dart';

class NewCounterPage extends StatelessWidget {
  const NewCounterPage({Key? key, required this.counterService})
      : super(key: key);

  final CounterService counterService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New counter"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: NewCounterForm(
              counterService: counterService,
            )),
          ),
        ));
  }
}
