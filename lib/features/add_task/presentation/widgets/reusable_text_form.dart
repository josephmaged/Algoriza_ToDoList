import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableTextForm extends StatelessWidget {
  final String hitText;
  final bool enabled;
  final Widget? suffixIcon;
 // final TextEditingController controller;

  const ReusableTextForm({
    Key? key,
    required this.hitText,
    this.enabled = true,
    this.suffixIcon,
    //required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
     // controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hitText,
        hintStyle: const TextStyle(color: kLightBlackColor),
        filled: true,
        fillColor: kLightColor,
        enabled: enabled,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
