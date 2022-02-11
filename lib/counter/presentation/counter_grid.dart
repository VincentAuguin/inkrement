import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_adapter.dart';

import '../domain/counter.dart';
import 'counter_tile.dart';

class CounterGrid extends StatelessWidget {
  const CounterGrid({Key? key, required this.counterAdapter}) : super(key: key);

  final CounterAdapter counterAdapter;

  void _incrementCounter(Counter counter, int value) {
    counterAdapter.updateValue(counter, value);
  }

  Widget _buildGridView(Iterable<Counter> counters) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.5,
        padding: const EdgeInsets.all(16),
        children: List.generate(
            counters.length,
            (index) => CounterTile(
                counter: counters.elementAt(index),
                onIncrement: _incrementCounter)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Counter>>(
        future: counterAdapter.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildGridView(snapshot.data!);
          } else {
            return const Text("Empty here");
          }
        });
  }
}
