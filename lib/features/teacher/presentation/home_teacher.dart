import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_chat/core/helper/extention.dart';
import 'package:intl/intl.dart';
import '../../../core/router/constants_route.dart';
import '../../admin/presentation/Studentpoints.dart';
import 'list_student_teacher.dart';

class HomeTeacher extends StatefulWidget {
  const HomeTeacher(
      {super.key, required this.firstnameargu, required this.email});
  static const String screenroute = 'hometeacher';
  final String firstnameargu;
  final String email;

  @override
  State<HomeTeacher> createState() => _hometeacherState();
}

class _hometeacherState extends State<HomeTeacher> {
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

  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedRecipientController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String firstName = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['firstName'];
    final String email = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['email'];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8576FF),

          iconTheme: const IconThemeData(
              color: Colors.white), // Set the color of the menu icon to white
          actions: [
            const Padding(
              padding: EdgeInsets.only(left: 110),
              child: Text(
                'Welcome Teacher',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ), // Adjust the radius as needed
                child: Container(
                  color: const Color(0xFF8576FF),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: Colors.white,
                    iconSize: 30.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              const Text(
                                'Send message',
                                style: TextStyle(
                                  color: Color(0xFF614BC3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 26),
                                child: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                          actions: [
                            Column(
                              children: [
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: _messageController,
                                  decoration: const InputDecoration(
                                    labelText: 'Message',
                                  ),
                                  maxLines: null,
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String messageText =
                                          _messageController.text.trim();
                                      if (messageText.isNotEmpty) {
                                        Navigator.of(context).pop();
                                        // Send message to recipient
                                        FirebaseFirestore.instance
                                            .collection('messages')
                                            .add({
                                          'send': email,
                                          'recipient': 'admin',
                                          'message': messageText,
                                          'timestamp': Timestamp.now(),
                                        });

                                        // Clear input fields
                                        _messageController.clear();
                                        _selectedRecipientController.clear();
                                      } else {
                                        // Show error message if recipient or message is empty
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              backgroundColor:
                                                  Color(0xFF33BBC5),
                                              content: Text(
                                                'Recipient and message cannot be empty',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        );
                                      }
                                    },
                                    child: const Text('Send Message'),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
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
                      fontSize: 24,
                    ),
                  ),
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
                    context.pushNamed(teacherListTeachersRoute);
                    // Navigator.pushNamed(
                    //     context, ListTeacherForTeacher.screenroute);
                  },
                ),
              ),
              const SizedBox(height: 5),
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
                    Navigator.pushNamed(
                        context, ListStudentTeacher.screenroute);
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
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 315),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ), // Adjust the radius as needed
                      child: Container(
                        color: const Color(0xFF8576FF),
                        child: IconButton(
                          icon: const Icon(Icons.email),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () {
                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> teacherWidgets = [];
                      if (snapshot.hasData) {
                        final users = snapshot.data!.docs.toList();
                        for (var user in users) {
                          if (user['role'] == 'Teacher' &&
                              user['firstname'] == firstName &&
                              user['email'] == email) {
                            String fullName =
                                '${user['firstname']} ${user['lastname']}';
                            final teacherWidget = Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage(''),
                                    backgroundColor: Color(0xFF33BBC5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      // '$firstName $lastName',
                                      '$fullName ',
                                      style: const TextStyle(
                                          fontFamily: 'OpenSansCondensed',
                                          fontSize: 40.0,
                                          color: Color(0xFF1C1678),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Text(
                                    'Teacher',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 20.0,
                                      color: Color(0xFF7BC9FF),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                    width: 150.0,
                                    child: Divider(
                                      color: Color(0xFF8576FF),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 5.0),
                                    color: const Color(0xFF33BBC5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.home_outlined,
                                        color: Colors.white,
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          user['paleacofr'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 5.0),
                                    color: const Color(0xFF33BBC5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.phone_outlined,
                                        color: Colors.white,
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          user['phone'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 5.0),
                                    color: const Color(0xFF33BBC5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          user['email'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 5.0),
                                    color: const Color(0xFF33BBC5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.cake_outlined,
                                        color: Colors.white,
                                      ),
                                      onTap: () {},
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          user['birthday'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 5.0),
                                    color: const Color(0xFF33BBC5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          user['InfoTeacher'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
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
                      if (message['recipient'] == email ||
                          message['recipient'] == 'allt') {
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 194,
                                        child: Text(
                                          message['message'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'SourceSansPro',
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                      Text(
                                        // Format the timestamp here
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

                  return Expanded(
                    child: ListView(
                      children: messagesWidgets,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
