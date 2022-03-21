import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter.dart';
import 'package:inkrement/shared/data/services.dart';

class EditCounterForm extends StatefulWidget {
  const EditCounterForm({Key? key, required this.counter}) : super(key: key);

  final Counter counter;

  @override
  State<StatefulWidget> createState() => _EditCounterFormState();
}

class _EditCounterFormState extends State<EditCounterForm> {
  final TextEditingController _controller = TextEditingController();

  void _updateCounterTitle(String title) {
    counterService.updateTitle(widget.counter, title);
  }

  @override
  Widget build(BuildContext context) {
    _controller.value = TextEditingValue(text: widget.counter.title);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextField(
        controller: _controller,
        minLines: 1,
        maxLines: 3,
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(hintText: "Title"),
        onChanged: _updateCounterTitle,
      ),
      const SizedBox(height: 32),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const AutoSizeText(
          "Done",
          maxLines: 1,
          style: TextStyle(fontSize: 18),
        ),
      )
    ]);
  }
}
