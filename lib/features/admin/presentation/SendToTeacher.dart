import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendToTeacher extends StatefulWidget {
  const SendToTeacher({super.key});
  static const screenroute = 'SendToTeacher';

  @override
  State<SendToTeacher> createState() => _SendToTeacherState();
}

class _SendToTeacherState extends State<SendToTeacher> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedRecipientController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        title: const Text('Send a Messages to teachers ',
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  width: 290,
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
                IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: const Color(0xFF614BC3),
                    iconSize: 30.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              const Text(
                                'All teachers',
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
                                  _messageController.clear();
                                  _selectedRecipientController.clear();
                                },
                              ),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                        FirebaseFirestore.instance
                                            .collection('messages')
                                            .add({
                                          'send': 'admin',
                                          'recipient': 'allt',
                                          'message': messageText,
                                          'timestamp': Timestamp.now(),
                                        });

                                        // Clear input fields
                                        _messageController.clear();
                                        _selectedRecipientController.clear();
                                      } else {
                                        // Show error message if message is empty
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Color(0xFF33BBC5),
                                            content: Text(
                                              'Message cannot be empty',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                          ),
                        ),
                      );
                    }),
              ],
            ),
            const SizedBox(height: 10.0),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                List<Widget> teacherWidgets = [];
                if (snapshot.hasData) {
                  final users = snapshot.data!.docs.toList();
                  for (var user in users) {
                    if (user['role'] == 'Teacher') {
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
                                width: 290,
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
                            IconButton(
                              icon: const Icon(Icons.send_rounded),
                              color: const Color(0xFF614BC3),
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
                                          padding:
                                              const EdgeInsets.only(left: 26),
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.cancel_outlined),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
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
                                                    _messageController.text
                                                        .trim();
                                                if (messageText.isNotEmpty) {
                                                  Navigator.of(context).pop();
                                                  FirebaseFirestore.instance
                                                      .collection('messages')
                                                      .add({
                                                    'send': 'admin',
                                                    'recipient': user['email'],
                                                    'message': messageText,
                                                    'timestamp':
                                                        Timestamp.now(),
                                                  });
                                                  _messageController.clear();
                                                  _selectedRecipientController
                                                      .clear();
                                                } else {
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
                                    ),
                                  ),
                                );
                              },
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
