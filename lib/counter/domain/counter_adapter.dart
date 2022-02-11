import 'package:inkrement/counter/domain/counter.dart';

abstract class CounterAdapter {
  Future<Iterable<Counter>> getAll();

  Future<void> updateValue(Counter counter, int value);
}
