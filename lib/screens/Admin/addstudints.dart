import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/removespeace.dart';

class MyHomePage extends StatefulWidget {
  static const String screenroute = 'MyHomePage';

  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String placeofresidence = 'Msila';
  String numClass = '1';
  String AcademicLevel = '0';
  String gender = '';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _parentnameController = TextEditingController();
  final TextEditingController _numclasstController = TextEditingController();
  final TextEditingController _numpController = TextEditingController();
  final TextEditingController _placeofresidenceController =
      TextEditingController();
  final TextEditingController _AcademicLevelController =
      TextEditingController();
  final TextEditingController _emailparentController = TextEditingController();

  Color _containerColor = Colors.black54;

  DateTime? _selectedDate; // Variable to store selected date

  bool _isButtonEnabled = false;

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_checkButtonEnabled);
    _lastNameController.addListener(_checkButtonEnabled);
    _parentnameController.addListener(_checkButtonEnabled);
    _numclasstController.addListener(_checkButtonEnabled);
    _numpController.addListener(_checkButtonEnabled);
    _placeofresidenceController.addListener(_checkButtonEnabled);
    _AcademicLevelController.addListener(_checkButtonEnabled);
    _emailparentController.addListener(_checkButtonEnabled);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _parentnameController.dispose();
    _numclasstController.dispose();
    _numpController.dispose();
    _placeofresidenceController.dispose();
    _AcademicLevelController.dispose();
    _emailparentController.dispose();
    super.dispose();
  }

  void _checkButtonEnabled() {
    setState(() {
      _isButtonEnabled = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _parentnameController.text.isNotEmpty &&
          _numpController.text.isNotEmpty &&
          _emailparentController.text.isNotEmpty &&
          _selectedDate != null;
    });
  }

  void _saveStudent() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String parentname = _parentnameController.text;
    String eamilparent = _emailparentController.text;
    String numparent = _numpController.text;
    String formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';

    FirebaseFirestore.instance.collection('Users').add({
      'firstname': firstName,
      'lastname': lastName,
      'Parent': parentname,
      'phone': numparent,
      'email': eamilparent,
      'numclasst': numClass,
      'Academiclevel': AcademicLevel,
      'paleacofr': placeofresidence,
      'role': 'Student',
      'birthday': formattedDate,
      'gender': gender,
      'studentrate': null,
      'math': null,
      'arabic': null,
      'fr': null,
      'english': null,
      'islamic': null,
      'historic': null,
      'gagr': null,
      'sport': null,
      'madaniya': null,
      'Science': null,
    }).then((_) {
      // Reset text fields after saving
      _firstNameController.clear();
      _lastNameController.clear();
      _parentnameController.clear();
      _numclasstController.clear();
      _numpController.clear();
      _placeofresidenceController.clear();
      _AcademicLevelController.clear();

      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors
      print("Error saving student: $error");
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF8576FF),
        title: const Text(
          '        Add Student',
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
              _saveStudent();
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
            title: const Text('Student Information'),
            isActive: _currentStep == 0,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
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
                const SizedBox(height: 16.0),
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
            title: const Text('Parent Information'),
            isActive: _currentStep == 1,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _parentnameController,
                  decoration: const InputDecoration(
                    labelText: 'Parent Name',
                  ),
                ),
                TextField(
                  inputFormatters: [NoTrailingSpaceFormatter()],
                  controller: _numpController,
                  decoration: const InputDecoration(
                    labelText: "Parent's Number telephone ",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  inputFormatters: [NoTrailingSpaceFormatter()],
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailparentController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: _isButtonEnabled ? _saveStudent : null,
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
