import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListStudentsForStudednt extends StatefulWidget {
  const ListStudentsForStudednt({super.key});
  static const screenroute = 'ListStudentsForStudednt';

  @override
  State<ListStudentsForStudednt> createState() =>
      _ListStudentsForStudedntState();
}

class _ListStudentsForStudedntState extends State<ListStudentsForStudednt> {
  String AcademicLevel = '0';
  String numClass = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text('List students',
            style: TextStyle(color: Colors.white, fontSize: 30)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFF614BC3),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                    child: Text(
                      'First Name' '         Last Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                List<Widget> teacherWidgets = [];
                if (snapshot.hasData) {
                  final users = snapshot.data!.docs.toList();
                  for (var user in users) {
                    if (user['role'] == 'Student' &&
                        user['Academiclevel'] == AcademicLevel &&
                        user['numclasst'] == numClass) {
                      final teacherWidget = Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                width: 250,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xFF33BBC5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 25),
                                  child: Text(
                                    '${user['firstname']}                 ${user['lastname']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      teacherWidgets.add(teacherWidget);
                    }
                  }
                }

                return Expanded(
                  child: ListView(
                    children: teacherWidgets,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
