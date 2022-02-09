import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key, required this.title, required this.count})
      : super(key: key);

  final String title;

  final int count;

  @override
  State<StatefulWidget> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        Text(
          _count.toString(),
          style: const TextStyle(fontSize: 96),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: _increment,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
            child: const Text(
              "+1",
              style: TextStyle(fontSize: 60),
            ))
      ],
    );
  }
}
