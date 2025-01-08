import 'package:flutter/material.dart';

class arraypage extends StatefulWidget {
  const arraypage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<arraypage> {
  List<String> dataArray = List.filled(10, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Array Widget Example'),
      ),
      body: ListView.builder(
        itemCount: dataArray.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TextField(
              onChanged: (value) {
                setState(() {
                  dataArray[index] = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter value for index $index',
              ),
            ),
          );
        },
      ),
      // Step(
      //   title: Text('Student Information'),
      //   isActive: _currentStep == 0,
      //   content: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextField(
      //         controller: _firstNameController,
      //         decoration: InputDecoration(
      //           labelText: 'First Name',
      //         ),
      //       ),
      //       TextField(
      //         controller: _lastNameController,
      //         decoration: InputDecoration(
      //           labelText: 'Last Name',
      //         ),
      //       ),
      //       Row(
      //         children: [
      //           Container(width: 140, child: Text('Number Class')),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 38),
      //             child: DropdownButton<String>(
      //               value: numClass,
      //               icon: const Icon(Icons.menu),
      //               style: const TextStyle(color: Colors.black),
      //               underline: Container(
      //                 height: 2,
      //                 color: Colors.black,
      //               ),
      //               onChanged: (String? newValue) {
      //                 setState(() {
      //                   numClass = newValue!;
      //                 });
      //               },
      //               items: const [
      //                 DropdownMenuItem(
      //                   value: '1',
      //                   child: Text('1'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '2',
      //                   child: Text('2'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '3',
      //                   child: Text('3'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '4',
      //                   child: Text('4'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '5',
      //                   child: Text('5'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Container(width: 140, child: Text('Academic Level')),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 38),
      //             child: DropdownButton<String>(
      //               value: AcademicLevel,
      //               icon: const Icon(Icons.menu),
      //               style: const TextStyle(color: Colors.black),
      //               underline: Container(
      //                 height: 2,
      //                 color: Colors.black,
      //               ),
      //               onChanged: (String? newValue) {
      //                 setState(() {
      //                   AcademicLevel = newValue!;
      //                 });
      //               },
      //               items: const [
      //                 DropdownMenuItem(
      //                   value: '0',
      //                   child: Text('0'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '1',
      //                   child: Text('1'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '2',
      //                   child: Text('2'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '3',
      //                   child: Text('3'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '4',
      //                   child: Text('4'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: '5',
      //                   child: Text('5'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Container(width: 140, child: Text('Place of residence')),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 20),
      //             child: DropdownButton<String>(
      //               value: placeofresidence,
      //               icon: const Icon(Icons.menu),
      //               style: const TextStyle(color: Colors.black),
      //               underline: Container(
      //                 height: 2,
      //                 color: Colors.black,
      //               ),
      //               onChanged: (String? newValue) {
      //                 setState(() {
      //                   placeofresidence = newValue!;
      //                 });
      //               },
      //               items: const [
      //                 DropdownMenuItem(
      //                   value: 'Msila',
      //                   child: Text('msila'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: 'bourdj',
      //                   child: Text('bourdj'),
      //                 ),
      //                 DropdownMenuItem(
      //                   value: 'boussada',
      //                   child: Text('boussada'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: 16.0),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 10),
      //         child: Container(
      //           height: 40,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.black54,
      //           ),
      //           child: TextButton(
      //             onPressed: () => _selectDate(context),
      //             child: Text(
      //               _selectedDate != null
      //                   ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
      //                   : 'Select Birthday',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('Gender'),
      //         subtitle: Text('Please select your gender'),
      //       ),
      //       RadioListTile<String>(
      //         title: Text('Male'),
      //         value: 'Male',
      //         groupValue: gender,
      //         onChanged: (value) {
      //           setState(() {
      //             gender = value!;
      //           });
      //           _checkButtonEnabled();
      //         },
      //       ),
      //       RadioListTile<String>(
      //         title: Text('Female'),
      //         value: 'Female',
      //         groupValue: gender,
      //         onChanged: (value) {
      //           setState(() {
      //             gender = value!;
      //           });
      //           _checkButtonEnabled();
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // Step(
      //   title: Text('Parent Information'),
      //   isActive: _currentStep == 1,
      //   content: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextField(
      //         controller: _parentnameController,
      //         decoration: InputDecoration(
      //           labelText: 'Parent Name',
      //         ),
      //       ),
      //       TextField(
      //         controller: _numpController,
      //         decoration: InputDecoration(
      //           labelText: "Parent's Number telephone ",
      //         ),
      //         keyboardType: TextInputType.phone,
      //
      //       ),
      //       TextField(
      //         keyboardType: TextInputType.emailAddress,
      //         controller: _emailparentController,
      //         decoration: InputDecoration(
      //           labelText: 'Email',
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: _isButtonEnabled ? _saveStudent : null,
      //         style: ButtonStyle(
      //           backgroundColor: MaterialStateProperty.all<Color>(
      //             _isButtonEnabled ? Colors.blue : Colors.grey,
      //           ),
      //         ),
      //         child: Text(
      //           'Save',
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Do something with the filled array
          print(dataArray);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
