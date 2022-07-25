import 'package:flutter/material.dart';

class ReusableColorButton extends StatelessWidget {
  final bool iconCondition;
  final Color iconColor;
  final VoidCallback onPressed;

  const ReusableColorButton({Key? key, required this.iconCondition, required this.iconColor, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: iconCondition
          ? Icon(
        Icons.radio_button_off,
        color: iconColor,
      )
          : Icon(
        Icons.check_circle,
        color: iconColor,
      ),
      iconSize: 35,
      onPressed: onPressed,
    );
  }
}
