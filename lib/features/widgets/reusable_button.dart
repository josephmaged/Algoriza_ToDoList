import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ReusableButton({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: kPrimaryColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
