import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/counter_adapter.dart';
import '../domain/counter.dart';

class FirestoreCounterAdapter implements CounterAdapter {
  CollectionReference getCollection() =>
      FirebaseFirestore.instance.collection("counters");

  @override
  Future<Iterable<Counter>> getAll() {
    return getCollection().get().then((QuerySnapshot snapshots) =>
        snapshots.docs.map((doc) => _toCounter(doc)));
  }

  @override
  Future<void> updateValue(Counter counter, int value) {
    return getCollection().doc(counter.id).update({"value": value});
  }

  Counter _toCounter(QueryDocumentSnapshot doc) {
    return Counter(doc.id, doc["title"], doc["value"]);
  }
}