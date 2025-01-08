import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class homestudent extends StatefulWidget {
  const homestudent({super.key});
  static const String screenroute = 'homestudent';
  @override
  State<homestudent> createState() => _homestudentState();
}

class _homestudentState extends State<homestudent> {
  final PageController _pageController = PageController(initialPage: 0);
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

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedRecipientController =
      TextEditingController();
  void list(String a, String b) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Text(
              'List Students',
              style: TextStyle(
                color: Color(0xFF614BC3),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.cancel_outlined),
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: SizedBox(
          height: 300, // Set a fixed height for the dialog content
          width: double.maxFinite,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Widget> teacherWidgets1 = [];
              final users1 = snapshot.data!.docs.toList();
              for (var user1 in users1) {
                if (user1['role'] == 'Student' &&
                    user1['Academiclevel'] == a &&
                    user1['numclasst'] == b) {
                  final teacherWidget1 = Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF33BBC5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              child: Text(
                                '${user1['firstname']} ${user1['lastname']}',
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
                  teacherWidgets1.add(teacherWidget1);
                }
              }

              return SingleChildScrollView(
                child: Column(
                  children: teacherWidgets1,
                ),
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(), // Placeholder for any action buttons or content
          ),
        ],
      ),
    );
  }

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
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF8576FF),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Welcome Student ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
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
                              const Expanded(
                                child: Text(
                                  'Send message',
                                  style: TextStyle(
                                      color: Color(0xFF614BC3), fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 26),
                                child: IconButton(
                                  icon: const Icon(Icons.send_rounded),
                                  color: const Color(0xFF8576FF),
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
                                                fontSize: 15,
                                                color: Color(0xFF614BC3),
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.cancel_outlined),
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: _messageController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Message',
                                                ),
                                                maxLines: null,
                                              ),
                                              const SizedBox(height: 16.0),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                String messageText =
                                                    _messageController.text
                                                        .trim();
                                                if (messageText.isNotEmpty) {
                                                  Navigator.of(context).pop();
                                                  // Send message to recipient
                                                  FirebaseFirestore.instance
                                                      .collection('messages')
                                                      .add({
                                                    'send': email,
                                                    'recipient': 'admin',
                                                    'message': messageText,
                                                    'timestamp':
                                                        Timestamp.now(),
                                                  });

                                                  // Clear input fields
                                                  _messageController.clear();
                                                  _selectedRecipientController
                                                      .clear();
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: const Text('Send Message'),
                                            ),
                                          ),
                                          const SizedBox(height: 16.0),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: SizedBox(
                              // Added content container
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('messages')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  List<Widget> messagesWidgets = [];
                                  if (snapshot.hasData) {
                                    final messages =
                                        snapshot.data!.docs.toList();
                                    messages.sort((a, b) {
                                      Timestamp timestampA = a['timestamp'];
                                      Timestamp timestampB = b['timestamp'];
                                      return timestampB.compareTo(timestampA);
                                    });
                                    for (var message in messages) {
                                      if (message['recipient'] == email ||
                                          message['recipient'] == 'alls') {
                                        final teacherWidget = Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Icon(
                                                      Icons.mail,
                                                      color: Color(0xFF8576FF),
                                                      size: 16,
                                                    ),
                                                  ),
                                                  const Text(
                                                    ' :',
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          'SourceSansPro',
                                                      color: Color(0xFF8576FF),
                                                    ),
                                                  ),
                                                  Card(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 2.0,
                                                            right: 2.0,
                                                            bottom: 2.0),
                                                    color:
                                                        const Color(0xFF33BBC5),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              width: 10),
                                                          SizedBox(
                                                            width: 137,
                                                            child: Text(
                                                              message[
                                                                  'message'],
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontFamily:
                                                                    'SourceSansPro',
                                                                color: Colors
                                                                    .grey
                                                                    .shade200,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            DateFormat('HH:mm')
                                                                .format(
                                                              (message['timestamp']
                                                                      as Timestamp)
                                                                  .toDate(),
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 335),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ), // Adjust the radius as needed
                        child: Container(
                          width: 100,
                          color: const Color(0xFF8576FF),
                          child: IconButton(
                            icon: const Icon(Icons.star),
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
                            if (user['role'] == 'Student' &&
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
                                    const Icon(
                                      Icons.school_sharp,
                                      size: 100,
                                      color: Color(0xFF33BBC5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        // '$firstName $lastName',
                                        '$fullName ',
                                        style: const TextStyle(
                                            fontFamily: 'OpenSansCondensed',
                                            fontSize: 30.0,
                                            color: Color(0xFF1C1678),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 120,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: const Border(
                                            bottom: BorderSide(
                                              color: Color(0xFF8576FF),
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: const Text(
                                          'Student',
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 20.0,
                                            color: Color(0xFF33BBC5),
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
                                          Icons.school_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Academic level : ${user['Academiclevel']}',
                                            style: TextStyle(
                                                fontSize: 16.0,
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
                                          Icons.class_outlined,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          //   return Studentdepertmant( StudentID: user.id,);
                                          // }
                                          // ));
                                        },
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Class number : ${user['numclasst']}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'SourceSansPro',
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40),
                                                child: IconButton(
                                                  icon: const Icon(
                                                      Icons.clear_all),
                                                  color: Colors.white,
                                                  iconSize: 25.0,
                                                  onPressed: () {
                                                    list(user['Academiclevel'],
                                                        user['numclasst']);
                                                  },
                                                ),
                                              ),
                                            ],
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
                                          Icons.perm_contact_calendar_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            user['Parent'],
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
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<Widget> teacherWidgets = [];
                        if (snapshot.hasData) {
                          final users = snapshot.data!.docs.toList();
                          for (var user in users) {
                            if (user['role'] == 'Student' &&
                                user['firstname'] == firstName) {
                              String fullName =
                                  '${user['firstname']} ${user['lastname']}';
                              final teacherWidget = Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 200,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: const Border(
                                            bottom: BorderSide(
                                              color: Color(0xFF8576FF),
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: const Text(
                                          'Student Pionts',
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 20.0,
                                            color: Color(0xFF33BBC5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Card(
                                      margin: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 15.0),
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Student rate : ${user['studentrate']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Math : ${user['math']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Arabic : ${user['arabic']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Natural Science : ${user['Science']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Franch : ${user['fr']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'English : ${user['english']}',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Islamic : ${user['islamic']}' ??
                                                'w',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'History : ${user['historic']}' ??
                                                'w',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'gagr : ${user['gagr']}' ?? 'w',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Sport : ${user['sport']}' ?? 'w',
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
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Civic education : ${user['madaniya']}' ??
                                                'w',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
