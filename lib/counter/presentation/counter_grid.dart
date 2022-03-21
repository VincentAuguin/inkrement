import 'package:flutter/material.dart';
import 'package:inkrement/shared/data/services.dart';
import 'package:inkrement/shared/presentation/no_content.dart';

import '../../shared/presentation/routes.dart';
import '../domain/counter.dart';
import 'counter_tile.dart';

class CounterGrid extends StatefulWidget {
  const CounterGrid({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CounterGridState();
}

class _CounterGridState extends State<CounterGrid> with RouteAware {
  late List<Counter> _counters;
  late bool _isLoading;

  Future<void> _fetchCounters() async {
    setState(() {
      _isLoading = true;
    });
    List<Counter> result = await counterService.getAll();
    setState(() {
      _isLoading = false;
      _counters = result;
    });
  }

  void _incrementCounter(Counter counter, int value) {
    counterService.updateValue(counter, value);
  }

  @override
  void initState() {
    super.initState();
    _counters = [];
    _isLoading = false;
    _fetchCounters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPop();
    _fetchCounters();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _buildData();
  }

  Widget _buildData() {
    return RefreshIndicator(
        child: _counters.isNotEmpty
            ? _buildGridView()
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                    child: const Center(
                      child: NoContent("No counters"),
                    ),
                    height: MediaQuery.of(context).size.height)),
        onRefresh: _fetchCounters);
  }

  Widget _buildGridView() {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.5,
        padding: const EdgeInsets.all(16),
        children: List.generate(
            _counters.length,
            (index) => CounterTile(
                counter: _counters.elementAt(index),
                onIncrement: _incrementCounter)));
  }
}
