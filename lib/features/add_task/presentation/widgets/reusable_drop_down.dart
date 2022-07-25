import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableDropDown extends StatelessWidget {
  Widget hint;
  String value;
  List<DropdownMenuItem<String>> items;

  void Function(String?) onChanged;

  ReusableDropDown({Key? key, required this.hint, required this.value, required this.items, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: kLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: hint,
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: kLightBlackColor,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
