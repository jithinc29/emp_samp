import 'package:flutter/material.dart';

class TeamMember extends StatelessWidget {
  final String name;
  TeamMember({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CircleAvatar(
            radius: 20,
           backgroundColor: Colors.white,
          ),
        ),
        // Text(name)
      ],
    );
  }
}