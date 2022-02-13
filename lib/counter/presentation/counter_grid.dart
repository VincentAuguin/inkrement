import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter_service.dart';
import 'package:inkrement/shared/presentation/no_content.dart';

import '../domain/counter.dart';
import 'counter_tile.dart';

class CounterGrid extends StatefulWidget {
  const CounterGrid(
      {Key? key, required this.counterService, required this.routeObserver})
      : super(key: key);

  final CounterService counterService;

  final RouteObserver routeObserver;

  @override
  State<StatefulWidget> createState() => _CounterGridState();
}

class _CounterGridState extends State<CounterGrid> with RouteAware {
  late List<Counter> _counters;

  Future<void> _fetchCounters() async {
    List<Counter> result = await widget.counterService.getAll();
    setState(() {
      _counters = result;
    });
  }

  void _incrementCounter(Counter counter, int value) {
    widget.counterService.updateValue(counter, value);
  }

  @override
  void initState() {
    super.initState();
    _counters = [];
    _fetchCounters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPop();
    _fetchCounters();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: _counters.isNotEmpty
            ? _buildGridView(_counters)
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                    child: const Center(
                      child: NoContent("No counters"),
                    ),
                    height: MediaQuery.of(context).size.height)),
        onRefresh: _fetchCounters);
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
}
