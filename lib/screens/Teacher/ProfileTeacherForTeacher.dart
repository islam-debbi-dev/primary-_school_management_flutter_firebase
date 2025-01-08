import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/DesignText.dart';

class ProfileTeacherForTeacher extends StatelessWidget {
  final String profileTeacherId;
  const ProfileTeacherForTeacher({super.key, required this.profileTeacherId});
  static const String screenroute = 'ProfileTeacherForTeacher';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(
          'Teacher Profile',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(profileTeacherId)
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
                  label: 'Class Number:',
                  value: userData['numclasst'] ?? 'N/A',
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
