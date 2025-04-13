import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/DesignText.dart';
import 'Studentpoints2.dart';

class Studentpoints1 extends StatelessWidget {
  final String ProfileStudentID;
  const Studentpoints1({super.key, required this.ProfileStudentID});
  static const String screenroute = 'Studentpoints1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text('Student points',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Studentpoints2(studentId: ProfileStudentID),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              iconSize: 30,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
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

          return Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfoItem(
                    label: 'Student rate:',
                    value: userData['studentrate'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Math:',
                    value: userData['math'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Natural Science :',
                    value: userData['Science'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Arabic:',
                    value: userData['arabic'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Franch :',
                    value: userData['fr'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'English :',
                    value: userData['english'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Islamic :',
                    value: userData['islamic'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'History :',
                    value: userData['historic'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Geography :',
                    value: userData['gagr'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Sport :',
                    value: userData['sport'] ?? 'N/A',
                  ),
                  UserInfoItem(
                    label: 'Civic education :',
                    value: userData['madaniya'] ?? 'N/A',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
