import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../widgets/DesignTectFormFiald.dart';

class UpdateTeacherPage extends StatefulWidget {
  final String teacherId;

  const UpdateTeacherPage({required this.teacherId, super.key});

  static const screenroute = 'UpdateTeacherPage';

  @override
  _UpdateTeacherPageState createState() => _UpdateTeacherPageState();
}

class _UpdateTeacherPageState extends State<UpdateTeacherPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final TextEditingController _placeofresidenceController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _numclasstController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime? _selectedDate;
  String placeofresidence = 'Msila';
  String numClass = '1';
  String AcademicLevel = '0';
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Update"),
          content: const Text(
              "Are you sure you want to update this teacher's details?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog and proceed with update
                _updateTeacher();
              },
              child: const Text('Update'),
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
        backgroundColor: const Color(0xFF8576FF),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Update Teacher',
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 140, child: const Text('Place of residence')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<String>(
                      value: placeofresidence,
                      icon: const Icon(
                        Icons.menu,
                      ),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF614BC3),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          placeofresidence = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Msila',
                          child: Text('msila'),
                        ),
                        DropdownMenuItem(
                          value: 'bourdj',
                          child: Text('bourdj'),
                        ),
                        DropdownMenuItem(
                          value: 'boussada',
                          child: Text('boussada'),
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
                controller: _phoneController,
                labelText: 'Phone Number',
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTeacher() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.teacherId)
        .update({
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailController.text,
      'Academiclevel': AcademicLevel,
      'paleacofr': _placeofresidenceController.text,
      'phone': _phoneController.text,
      'birthday': _selectedDate != null
          ? _selectedDate!.toLocal().toString().split(' ')[0]
          : null,
    }).then((_) {
      // Update successful, navigate back to the previous screen or any other logic you want to apply.
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors if any.
      print("Failed to update teacher: $error");
      // Show error message to the user if necessary.
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.teacherId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          firstNameController.text = documentSnapshot['firstname'] ?? '';
          lastNameController.text = documentSnapshot['lastname'] ?? '';
          _placeofresidenceController.text =
              documentSnapshot['paleacofr'] ?? '';
          _phoneController.text = documentSnapshot['phone'] ?? '';
          emailController.text = documentSnapshot['email'] ?? '';
          _selectedDate = documentSnapshot['birthday'] != null
              ? DateTime.parse(documentSnapshot['birthday'])
              : null;

          AcademicLevel = documentSnapshot['Academiclevel'] ?? '';
        });
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    _placeofresidenceController.dispose();
    _phoneController.dispose();
    _numclasstController.dispose();
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
