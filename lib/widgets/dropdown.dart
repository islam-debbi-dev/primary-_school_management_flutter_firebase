import 'package:flutter/material.dart';

class dropdown extends StatefulWidget {
  const dropdown({super.key});

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  String dropdwonvalue = 'msila';
  @override

  Widget build(BuildContext context) {
    return Center(
      child:
      DropdownButton<String>(
        value: dropdwonvalue,
        icon: const Icon(Icons.menu),
        style: const TextStyle(color: Colors.white),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? newValue){
          setState(() {
            dropdwonvalue = newValue!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'msila',
            child: Text('msila'),
            ),
          DropdownMenuItem(
            value: 'out msila',
            child: Text('out msila'),
          ),
          DropdownMenuItem(
            value: 'Alg',
            child: Text('Alg'),
          ),
        ],
      ),
    );
  }
}
