import 'package:flutter/material.dart';

class ReusableTabSelector extends StatelessWidget {
  final String text;

  const ReusableTabSelector({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
