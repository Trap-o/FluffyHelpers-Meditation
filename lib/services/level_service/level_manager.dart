import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LevelManager extends ChangeNotifier {
  LevelManager._privateConstructor();

  static final LevelManager instance = LevelManager._privateConstructor();

  int _exp = 0;

  int get exp => _exp;

  Future<void> loadExp() async {
    _exp = await userExp();
    notifyListeners();
  }

  StreamSubscription<DocumentSnapshot>? _subscription;

  void startListeningToExp() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _subscription = FirebaseFirestore.instance
        .collection('level')
        .doc(user.uid)
        .snapshots()
        .listen((snapshot) {
      _exp = snapshot.data()?['exp'] ?? 0;
      notifyListeners();
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }


  Future<int> userExp() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final uid = user.uid;

    final doc = await FirebaseFirestore.instance.collection('level').doc(uid).get();

    if (doc.exists && doc.data() != null && doc.data()!.containsKey('exp')) {
      return doc['exp'] as int;
    } else {
      return 0;
    }
  }

  Future<void> addExp(int delta) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final uid = user.uid;
    final docRef = FirebaseFirestore.instance.collection('level').doc(uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      int currentExp = 0;
      if (snapshot.exists && snapshot.data() != null && snapshot.data()!.containsKey('exp')) {
        currentExp = snapshot['exp'] as int;
      }

      final updatedExp = currentExp + delta;

      transaction.set(docRef, {'exp': updatedExp}, SetOptions(merge: true));
    });
    notifyListeners();
  }
}
