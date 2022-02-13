import 'package:inkrement/counter/domain/counter.dart';

abstract class CounterService {
  Future<List<Counter>> getAll();

  Future<void> updateValue(Counter counter, int value);

  Future<void> create(String title);
}
