import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_service.dart';

class NewCounterForm extends StatefulWidget {
  const NewCounterForm({Key? key, required this.counterService})
      : super(key: key);

  final CounterService counterService;

  @override
  State<StatefulWidget> createState() => _NewCounterFormState();
}

class _NewCounterFormState extends State<NewCounterForm> {
  final TextEditingController _controller = TextEditingController();

  void _createCounter() {
    widget.counterService
        .create(_controller.text)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextField(
        controller: _controller,
        minLines: 1,
        maxLines: 3,
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(hintText: "Title"),
      ),
      const SizedBox(height: 32),
      ElevatedButton(
        onPressed: _createCounter,
        child: const AutoSizeText(
          "Create",
          maxLines: 1,
          style: TextStyle(fontSize: 18),
        ),
      )
    ]);
  }
}
