import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class TestFireBase extends StatefulWidget {
  const TestFireBase({super.key});

  @override
  State<TestFireBase> createState() => _CreatePageState();
}

class _CreatePageState extends State<TestFireBase> {
  String status = "Testing Firestore...";
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  void initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
      testFireBase();
    } catch (e) {
      setState(() {
        status = "Error initializing Firebase: $e";
      });
    }
  }

  void testFireBase() async {
    if (!_initialized) return;
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.settings = const Settings(persistenceEnabled: true);
      await firestore.collection('test').get();
      setState(() {
        status = "Success";
      });
    } catch (e) {
      setState(() {
        status = "Error accessing Firestore: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(status),
    ));
  }
}
