import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableTextForm extends StatelessWidget {
  final String hitText;
  final bool enabled;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType? textType;
  FormFieldValidator<String>?  validator;

  ReusableTextForm({
    Key? key,
    required this.hitText,
    this.enabled = true,
    this.suffixIcon,
    required this.controller,
    this.validator,
    required this.textType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textType,
      controller: controller,
      validator: validator,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
