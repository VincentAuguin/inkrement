import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inkrement/auth/domain/auth_service.dart';
import 'package:inkrement/auth/domain/user.dart';

import '../domain/counter.dart';
import '../domain/counter_service.dart';

class FirestoreCounterService implements CounterService {
  FirestoreCounterService(this._authService);

  final AuthService _authService;

  CollectionReference getCollection() =>
      FirebaseFirestore.instance.collection("counters");

  @override
  Future<List<Counter>> getAll() {
    final User? user = _authService.getUser();
    if (user != null) {
      return getCollection()
          .where("author", isEqualTo: user.id)
          .orderBy("updatedAt", descending: true)
          .get()
          .then((QuerySnapshot snapshots) =>
              snapshots.docs.map((doc) => _toCounter(doc)).toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> updateValue(Counter counter, int value) {
    return getCollection().doc(counter.id).update(
        {"value": value, "updatedAt": DateTime.now().millisecondsSinceEpoch});
  }

  @override
  Future<void> create(String title) {
    final User? user = _authService.getUser();
    if (user != null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      return getCollection().add({
        "author": user.id,
        "title": title,
        "value": 0,
        "createdAt": timestamp,
        "updatedAt": timestamp
      });
    } else {
      return Future.value();
    }
  }

  Counter _toCounter(QueryDocumentSnapshot doc) {
    return Counter(doc.id, doc["author"], doc["title"], doc["value"]);
  }
}
