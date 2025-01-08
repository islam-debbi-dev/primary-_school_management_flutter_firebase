import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class updateforme extends StatefulWidget {
  const updateforme(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.Parent,
      required this.student}); // Added a semicolon here
  final String firstname;
  final String lastname;
  final String Parent;
  final String student;

  @override
  State<updateforme> createState() => _updateformeState();
}

class _updateformeState extends State<updateforme> {
  @override
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final parentcontroller = TextEditingController();
  @override
  void initState() {
    firstnamecontroller.text = widget.firstname;
    lastnamecontroller.text = widget.lastname;
    parentcontroller.text = widget.Parent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: firstnamecontroller,
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
        ),
        TextField(
          controller: lastnamecontroller,
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
        ),
        TextField(
          controller: parentcontroller,
          decoration: const InputDecoration(
            labelText: 'Parent Name',
          ),
        ),
        ElevatedButton(
            onPressed: () {
              var collection =
                  FirebaseFirestore.instance.collection('students');
              collection.doc(widget.student).update({
                'firstname': firstnamecontroller.text,
                'lastname': lastnamecontroller.text,
                'Parent': parentcontroller.text,
              });
              Navigator.pop(context);
            },
            child: const Text('Updata Student'))
      ],
    );
  }
}
