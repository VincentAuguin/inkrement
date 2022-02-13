import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_service.dart';
import 'package:inkrement/counter/presentation/counter_grid.dart';
import 'package:inkrement/counter/presentation/new_counter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {Key? key, required this.counterService, required this.routeObserver})
      : super(key: key);

  final CounterService counterService;

  final RouteObserver routeObserver;

  void _newCounter(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewCounterPage(counterService: counterService)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CounterGrid(
              counterService: counterService, routeObserver: routeObserver)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _newCounter(context);
        },
      ),
    );
  }
}
