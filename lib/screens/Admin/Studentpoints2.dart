import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/DesignTectFormFiald.dart';

class Studentpoints2 extends StatefulWidget {
  final String studentId;

  const Studentpoints2({required this.studentId, super.key});

  static const screenroute = 'Studentpoints2';
  @override
  State<Studentpoints2> createState() => _Studentpoints2State();
}

class _Studentpoints2State extends State<Studentpoints2> {
  TextEditingController StudentrateController = TextEditingController();

  TextEditingController MathController = TextEditingController();
  TextEditingController ScController = TextEditingController();
  TextEditingController ArabicController = TextEditingController();
  TextEditingController FrController = TextEditingController();
  TextEditingController EnController = TextEditingController();
  TextEditingController IslamicController = TextEditingController();
  TextEditingController HistoricController = TextEditingController();
  TextEditingController GagraficController = TextEditingController();
  TextEditingController SportController = TextEditingController();
  TextEditingController MadaniyaController = TextEditingController();

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
        backgroundColor: const Color(0xFF8576FF),
        title:
            const Text('Update points', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: StudentrateController,
                labelText: "Student rate",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                decoration: const BoxDecoration(
                    color: Color(0xFF614BC3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.only(left: 75, top: 5, bottom: 5),
                  child: Text(
                    'Material points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                controller: MathController,
                labelText: "Math",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: ScController,
                labelText: "Natural Science",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: ArabicController,
                labelText: "Arabic",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: FrController,
                labelText: "Franch",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: EnController,
                labelText: "English",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: IslamicController,
                labelText: "Islamic",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: HistoricController,
                labelText: "History",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: GagraficController,
                labelText: "Geography",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: SportController,
                labelText: "Sport",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: MadaniyaController,
                labelText: "Civic education",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
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
      'math': MathController.text,
      'arabic': ArabicController.text,
      'fr': FrController.text,
      'english': EnController.text,
      'islamic': IslamicController.text,
      'historic': HistoricController.text,
      'gagr': GagraficController.text,
      'sport': SportController.text,
      'madaniya': MadaniyaController.text,
      'studentrate': StudentrateController.text,
      'Science': ScController.text,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to update student: $error");
    });
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
          MathController.text = documentSnapshot['math'];
          ArabicController.text = documentSnapshot['arabic'];
          FrController.text = documentSnapshot['fr'];
          EnController.text = documentSnapshot['english'];
          IslamicController.text = documentSnapshot['islamic'];
          HistoricController.text = documentSnapshot['historic'];
          GagraficController.text = documentSnapshot['gagr'];
          SportController.text = documentSnapshot['sport'];
          MadaniyaController.text = documentSnapshot['madaniya'];
          StudentrateController.text = documentSnapshot['studentrate'];
          ScController.text = documentSnapshot['Science'];
        });
      }
    });
  }

  @override
  void dispose() {
    StudentrateController.dispose();
    MathController.dispose();
    ArabicController.dispose();
    ArabicController.dispose();
    FrController.dispose();
    EnController.dispose();
    IslamicController.dispose();
    HistoricController.dispose();
    GagraficController.dispose();
    SportController.dispose();
    MadaniyaController.dispose();
    ScController.dispose();
    super.dispose();
  }
}
