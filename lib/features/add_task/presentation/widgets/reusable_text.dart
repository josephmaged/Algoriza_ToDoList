import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableText extends StatelessWidget {
  final String text;

  const ReusableText({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: kBlackColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
