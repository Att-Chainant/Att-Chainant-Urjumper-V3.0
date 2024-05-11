import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          //color: Color.fromARGB(255, 113, 106, 162),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(25),
        child: Text(
          'everyone flies.. some fly longer than others',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
