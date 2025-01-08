// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DataManager {
//   static final DataManager _instance = DataManager._internal();
//   factory DataManager() {
//     return _instance;
//   }
//   DataManager._internal();
//
//   String _sharedVariable;
//   String get sharedVariable => _sharedVariable;
//
//   Future<void> fetchDataFromFirestore() async {
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//         .collection('yourCollection')
//         .doc('yourDocument')
//         .get();
//     _sharedVariable = documentSnapshot['yourField'];
//   }
// }
