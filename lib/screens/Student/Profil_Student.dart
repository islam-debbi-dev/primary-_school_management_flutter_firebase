import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/DesignText.dart';
import '../Admin/Update_Student.dart';

class ProfileStudentPage extends StatelessWidget {
  final String ProfileStudentID;
  const ProfileStudentPage({super.key, required this.ProfileStudentID});
  static const String screenroute = 'ProfileTeacherPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(
          'Student Profile',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateStudentPage(studentId: ProfileStudentID),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              iconSize: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(ProfileStudentID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var userData = snapshot.data!.data() as Map<String,
              dynamic>?; // Explicitly cast to Map<String, dynamic>
          if (userData == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          return SingleChildScrollView(
            // Added SingleChildScrollView
            padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoItem(
                  label: 'First Name :',
                  value: userData['firstname'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Last Name :',
                  value: userData['lastname'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Place of Residence :',
                  value: userData['paleacofr'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Birthday :',
                  value: userData['birthday'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Academic level :',
                  value: userData['Academiclevel'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Class Number :',
                  value: userData['numclasst'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Parent name :',
                  value: userData['Parent'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Number Parent :',
                  value: userData['phone'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Email :',
                  value: userData['email'] ?? 'N/A',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
