import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/DesignTectFormFiald.dart';

class UpdateStudentPage extends StatefulWidget {
  final String studentId;

  const UpdateStudentPage({required this.studentId, super.key});

  static const screenroute = 'UpdateStudentPage';

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController classNumberController = TextEditingController();
  TextEditingController academicLevelController = TextEditingController();
  TextEditingController placeOfResidenceController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime? _selectedDate;
  String AcademicLevel = "0";
  String numClass = "1";
  String placeofresidence = 'Msila';
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Update"),
          content: const Text(
              "Are you sure you want to update this student's details?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _updateStudent(); // Update the student details
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(
          'Update Student',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: firstNameController,
                labelText: 'First Name',
              ),
              CustomTextFormField(
                controller: lastNameController,
                labelText: 'Last Name',
              ),
              Row(
                children: [
                  SizedBox(width: 140, child: const Text('Place of residence')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<String>(
                      value: placeofresidence,
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xFF8576FF),
                      ),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF8576FF),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          placeofresidence = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Msila',
                          child: Text("M'sila"),
                        ),
                        DropdownMenuItem(
                          value: 'bourdj',
                          child: Text('Bourdj'),
                        ),
                        DropdownMenuItem(
                          value: 'boussada',
                          child: Text('Boussada'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 140, child: const Text('Number Class')),
                  Padding(
                    padding: const EdgeInsets.only(left: 38),
                    child: DropdownButton<String>(
                      value: numClass,
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xFF8576FF),
                        size: 17,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF8576FF),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          numClass = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('1 '),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('2 '),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('3 '),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Text('4 '),
                        ),
                        DropdownMenuItem(
                          value: '5',
                          child: Text('5 '),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 140, child: const Text('Academic Level')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child: DropdownButton<String>(
                      value: AcademicLevel,
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xFF8576FF),
                        size: 17,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF8576FF),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          AcademicLevel = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '0',
                          child: Text('0 '),
                        ),
                        DropdownMenuItem(
                          value: '1',
                          child: Text('1 '),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('2 '),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('3 '),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Text('4 '),
                        ),
                        DropdownMenuItem(
                          value: '5',
                          child: Text('5 '),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      _formatDate(_selectedDate),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: parentNameController,
                labelText: 'Parent Name',
              ),
              CustomTextFormField(
                controller: phoneController,
                labelText: "Parent's Number",
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateStudent() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.studentId)
        .update({
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'Parent': parentNameController.text,
      'phone': phoneController.text,
      'birthday': _selectedDate != null
          ? _selectedDate!.toLocal().toString().split(' ')[0]
          : null,
      'numclasst': numClass,
      'Academiclevel': AcademicLevel,
      'paleacofr': placeofresidence,
      'email': emailController.text,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {});
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.studentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          firstNameController.text = documentSnapshot['firstname'];
          lastNameController.text = documentSnapshot['lastname'];
          parentNameController.text = documentSnapshot['Parent'];
          phoneController.text = documentSnapshot['phone'];
          numClass = documentSnapshot['numclasst'];
          AcademicLevel = documentSnapshot['Academiclevel'] ?? '';
          placeofresidence = documentSnapshot['paleacofr'] ?? '';
          emailController.text = documentSnapshot['email'] ?? '';
          _selectedDate = documentSnapshot['birthday'] != null
              ? DateTime.parse(documentSnapshot['birthday'])
              : null;
        });
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    parentNameController.dispose();
    phoneController.dispose();
    classNumberController.dispose();
    academicLevelController.dispose();
    placeOfResidenceController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').format(date);
    }
    return 'Select Birthday';
  }
}
