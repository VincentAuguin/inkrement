import 'package:inkrement/counter/domain/counter.dart';

abstract class CounterService {
  Future<List<Counter>> getAll();

  Future<void> updateValue(Counter counter, int value);

  Future<void> updateTitle(Counter counter, String title);

  Future<void> create(String title);
}
