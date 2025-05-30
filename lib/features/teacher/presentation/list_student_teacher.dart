import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'profile_student_teacher.dart';

class ListStudentTeacher extends StatefulWidget {
  const ListStudentTeacher({super.key});
  static const screenroute = 'ListStudentTeacher';

  @override
  State<ListStudentTeacher> createState() => _ListStudentTeacherState();
}

class _ListStudentTeacherState extends State<ListStudentTeacher> {
  String AcademicLevel = '0';
  String numClass = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text('List students',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        width: 190,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF614BC3),
                ),
                child: Text(
                  'List of Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    child: DropdownButton<String>(
                      value: AcademicLevel,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 9, right: 1),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Color(0xFF614BC3), // Desired color for the icon
                            BlendMode.srcIn,
                          ),
                          child: Icon(Icons.menu),
                        ),
                      ),
                      style: const TextStyle(
                          color: Color(0xFF614BC3), fontSize: 16),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF614BC3),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          AcademicLevel = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '0',
                          child: Text('Academic Level 0'),
                        ),
                        DropdownMenuItem(
                          value: '1',
                          child: Text('Academic Level 1'),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('Academic Level 2'),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('Academic Level 3'),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Text('Academic Level 4'),
                        ),
                        DropdownMenuItem(
                          value: '5',
                          child: Text('Academic Level 5'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 20),
                  child: Container(
                    child: DropdownButton<String>(
                      value: numClass,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 10, right: 1),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Color(0xFF614BC3), // Desired color for the icon
                            BlendMode.srcIn,
                          ),
                          child: Icon(Icons.menu),
                        ),
                      ),
                      style: const TextStyle(
                          color: Color(0xFF614BC3), fontSize: 17),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF614BC3),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          numClass = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('Class number 1'),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('Class number 2'),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('Class number 3'),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Text('Class number 4'),
                        ),
                        DropdownMenuItem(
                          value: '5',
                          child: Text('Class number 5'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFF614BC3),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                    child: Text(
                      '                   Full Name',
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
                                width: 300,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xFF33BBC5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 25),
                                  child: Text(
                                    '         ${user['firstname']}       ${user['lastname']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return ProfileStudentTeacher(
                                      ProfileStudentTID: user.id);
                                }));
                              },
                              icon: const Icon(Icons.supervised_user_circle),
                              iconSize: 30, // Adjust icon size as needed
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
