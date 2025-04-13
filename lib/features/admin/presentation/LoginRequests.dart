import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginRequests extends StatefulWidget {
  const LoginRequests({super.key});
  static const screenroute = 'LoginRequests';

  @override
  State<LoginRequests> createState() => _LoginRequestsState();
}

class _LoginRequestsState extends State<LoginRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(' Login requests',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Loginrequest')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<Widget> messagesWidgets = [];
                    if (snapshot.hasData) {
                      final messages = snapshot.data!.docs.toList();
                      messages.sort((a, b) {
                        Timestamp timestampA = a['timestamp'];
                        Timestamp timestampB = b['timestamp'];
                        return timestampB.compareTo(timestampA);
                      });
                      for (var message in messages) {
                        if (message['recipient'] == 'admin') {
                          final teacherWidget = Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.mail,
                                    color: Color(0xFF8576FF),
                                  ),
                                ),
                                const Text(
                                  ' :',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'SourceSansPro',
                                    color: Color(0xFF8576FF),
                                  ),
                                ),
                                Card(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0, bottom: 5.0),
                                  color: const Color(0xFF33BBC5),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 194,
                                              child: Text(
                                                '${message['send']}  :',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'SourceSansPro',
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width: 194,
                                              child: Text(
                                                message['message'],
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'SourceSansPro',
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(
                                            (message['timestamp'] as Timestamp)
                                                .toDate(),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          messagesWidgets.add(teacherWidget);
                        }
                      }
                    }
                    return ListView(
                      children: messagesWidgets,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
