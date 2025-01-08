import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Admin/updateteacher.dart';

import 'package:for_chat/widgets/DesignText.dart';

class ProfileTeacherPage extends StatelessWidget {
  final String profileId;
  const ProfileTeacherPage({super.key, required this.profileId});
  static const String screenroute = 'ProfileTeacherPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(
          'Teacher Profile',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateTeacherPage(teacherId: profileId),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(profileId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>?;
          if (userData == null) {
            return const Center(
              child: Text('No data available'),
            );
          }
          print(userData['AcademicLevel']);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoItem(
                  label: 'First Name:',
                  value: userData['firstname'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Last Name:',
                  value: userData['lastname'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Academic Level:',
                  value: userData['Academiclevel'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Number Telephone:',
                  value: userData['phone'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Email:',
                  value: userData['email'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Place of Residence:',
                  value: userData['paleacofr'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'Birthday:',
                  value: userData['birthday'] ?? 'N/A',
                ),
                UserInfoItem(
                  label: 'More information:',
                  value: userData['InfoTeacher'] ?? 'N/A',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
