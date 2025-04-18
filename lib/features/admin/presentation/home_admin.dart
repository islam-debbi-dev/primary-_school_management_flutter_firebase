import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_chat/features/admin/presentation/add_teacher.dart';
import 'package:for_chat/features/admin/presentation/listteacher.dart';
import 'package:intl/intl.dart';
import 'LoginRequests.dart';
import 'MessagesForStdents.dart';
import 'SendToTeacher.dart';
import 'Studentpoints.dart';
import 'addstudints.dart';
import '../../../widgets/Dataservice.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin(
      {super.key, required this.firstnameargu, required this.email});
  static const String screenroute = 'homeadmin';
  final String firstnameargu;
  final String email;
  @override
  State<HomeAdmin> createState() => _homeadminState();
}

class _homeadminState extends State<HomeAdmin> {
  final DatabaseService dbService = DatabaseService();
  String AcademicLevel = '0';
  String numClass = '1';
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedRecipientController =
      TextEditingController();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = 'islam';
    // (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['firstName'];
    final String email = 'islam';

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8576FF),
          title: Text(' Admin $firstName',
              style: const TextStyle(color: Colors.white, fontSize: 30)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          width: 230,
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 130,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF614BC3),
                  ),
                  child: Text(
                    'List of Options',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'Send message',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context, MessagesForStudents.screenroute);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'messages to teachers',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, SendToTeacher.screenroute);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'Add Teacher',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AddTeacher.screenroute);
                  },
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'List Teacher',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ListTeachers.screenroute);
                  },
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'Add Student',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, MyHomePage.screenroute);
                  },
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'List Students',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    //   Navigator.pushNamed(context, liststudents.screenroute);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'Student points',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Studentpoints.screenroute);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF8576FF),
                      width: 2.0, // Border width
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8576FF).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'Login requests',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, LoginRequests.screenroute);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'SourceSansPro',
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            DateFormat('HH:mm').format(
                                              (message['timestamp']
                                                      as Timestamp)
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
      ),
    );
  }
}
