import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusablePickerText extends StatelessWidget {
  String value;
  GestureTapCallback onTap;
  IconData icon;

  ReusablePickerText({Key? key, required this.value, required this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: kLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: kLightBlackColor,
                fontSize: 16,
              ),
            ),
            Icon(
              icon,
              color: kLightBlackColor,
            )
          ],
        ),
      ),
    );
  }
}
