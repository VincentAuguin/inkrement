import 'package:flutter/material.dart';
import 'package:inkrement/counter/presentation/counter_grid.dart';
import 'package:inkrement/counter/presentation/new_counter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  void _newCounter(BuildContext context) {
    Navigator.pushNamed(context, NewCounterPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: CounterGrid()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _newCounter(context);
        },
      ),
    );
  }
}
