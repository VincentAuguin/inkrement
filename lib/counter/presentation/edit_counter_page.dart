import 'package:flutter/material.dart';
import 'package:inkrement/counter/presentation/edit_counter_form.dart';
import 'package:inkrement/counter/presentation/navigation/edit_counter_page_argument.dart';

class EditCounterPage extends StatelessWidget {
  const EditCounterPage({Key? key}) : super(key: key);

  static const String route = '/edit';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditCounterPageArgument;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit counter"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: EditCounterForm(
              counter: args.counter,
            )),
          ),
        ));
  }
}
