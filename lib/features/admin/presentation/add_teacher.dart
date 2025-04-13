import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/removespeace.dart';

class AddTeacher extends StatefulWidget {
  static const String screenroute = 'addteacher ';

  const AddTeacher({super.key});

  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  String placeofresidence = 'Msila';
  String AcademicLevel = '0';
  String gender = '';

  final TextEditingController _firstNameTeacherController =
      TextEditingController();
  final TextEditingController _lastNameTeacherController =
      TextEditingController();
  final TextEditingController _numTeacherController = TextEditingController();
  final TextEditingController _numClassController = TextEditingController();
  final TextEditingController _placeOfResidenceController =
      TextEditingController();
  final TextEditingController _InfoteacherController = TextEditingController();
  final TextEditingController _AcademicLevelController =
      TextEditingController();
  final TextEditingController _emailTeacherController = TextEditingController();

  DateTime? _selectedDate;
  Color _containerColor = Colors.black54;

  bool _isButtonEnabled = false;

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _firstNameTeacherController.addListener(_checkButtonEnabled);
    _lastNameTeacherController.addListener(_checkButtonEnabled);
    _numClassController.addListener(_checkButtonEnabled);
    _numTeacherController.addListener(_checkButtonEnabled);
    _placeOfResidenceController.addListener(_checkButtonEnabled);
    _InfoteacherController.addListener(_checkButtonEnabled);
    _AcademicLevelController.addListener(_checkButtonEnabled);
    _emailTeacherController.addListener(_checkButtonEnabled);
  }

  @override
  void dispose() {
    _firstNameTeacherController.dispose();
    _lastNameTeacherController.dispose();
    _numClassController.dispose();
    _numTeacherController.dispose();
    _placeOfResidenceController.dispose();
    _InfoteacherController.dispose();
    _AcademicLevelController.dispose();
    _emailTeacherController.dispose();

    super.dispose();
  }

  void _checkButtonEnabled() {
    setState(() {
      _isButtonEnabled = _firstNameTeacherController.text.isNotEmpty &&
          _lastNameTeacherController.text.isNotEmpty &&
          _numTeacherController.text.isNotEmpty &&
          _selectedDate != null &&
          _InfoteacherController.text.isNotEmpty &&
          _emailTeacherController.text.isNotEmpty;
    });
  }

  void _saveTeacher() {
    String firstName = _firstNameTeacherController.text;
    String lastName = _lastNameTeacherController.text;
    String numTeacher = _numTeacherController.text;
    String Infoteacher = _InfoteacherController.text;
    String emailtecher = _emailTeacherController.text;
    String formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';

    FirebaseFirestore.instance.collection('Users').add({
      'firstname': firstName,
      'lastname': lastName,
      'Academiclevel': AcademicLevel,
      'phone': numTeacher,
      'email': emailtecher,
      'InfoTeacher': Infoteacher,
      'paleacofr': placeofresidence,
      'role': 'Teacher',
      'birthday': formattedDate,
      'gender': gender,
    }).then((_) {
      // Reset text fields after saving
      _firstNameTeacherController.clear();
      _lastNameTeacherController.clear();
      _numClassController.clear();
      _numTeacherController.clear();
      _placeOfResidenceController.clear();
      _AcademicLevelController.clear();
      _emailTeacherController.clear();
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors
      print("Error saving teacher: $error");
    });
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
        _containerColor = const Color(0xFF8576FF);
      });
    }
    _checkButtonEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8576FF),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          '          Add Teacher',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          // Hide the 'CANCEL' button if it's the first step
          final bool isFirstStep = _currentStep == 0;

          // Hide the 'NEXT' button if it's the last step
          final bool isLastStep = _currentStep ==
              2 - 1; // Replace _totalSteps with the total number of steps

          return Row(
            children: <Widget>[
              if (!isFirstStep) // Only show if not the first step
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              if (!isLastStep) // Only show if not the last step
                TextButton(
                  onPressed: details.onStepContinue,
                  child: const Text('NEXT'),
                ),
            ],
          );
        },
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            if (_currentStep < 1) {
              _currentStep += 1;
            } else {
              _saveTeacher();
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        steps: [
          Step(
            title: const Text('Teacher Information'),
            isActive: _currentStep == 0,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _firstNameTeacherController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  controller: _lastNameTeacherController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
                TextField(
                  inputFormatters: [NoTrailingSpaceFormatter()],
                  keyboardType: TextInputType.phone,
                  controller: _numTeacherController,
                  decoration: const InputDecoration(
                    labelText: 'Number Telephone',
                  ),
                ),
                TextField(
                  inputFormatters: [NoTrailingSpaceFormatter()],
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTeacherController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 140, child: const Text('Place of residence')),
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
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
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _containerColor,
                    ),
                    child: TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        _selectedDate != null
                            ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                            : 'Select Birthday',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  title: Text('Gender'),
                  subtitle: Text('Please select your gender'),
                ),
                RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                    _checkButtonEnabled();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                    _checkButtonEnabled();
                  },
                ),
              ],
            ),
          ),
          Step(
            title: const Text('More informations'),
            isActive: _currentStep == 1,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _InfoteacherController,
                  decoration: const InputDecoration(
                    labelText: 'More informations',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: _isButtonEnabled ? _saveTeacher : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      _isButtonEnabled ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
