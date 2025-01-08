import 'package:flutter/material.dart';

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF614BC3),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
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
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value,
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
  }
}
