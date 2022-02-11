import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_adapter.dart';
import 'package:inkrement/counter/presentation/counter_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.counterAdapter}) : super(key: key);

  final CounterAdapter counterAdapter;

  @override
  Widget build(BuildContext context) {
    return CounterGrid(counterAdapter: counterAdapter);
  }
}
