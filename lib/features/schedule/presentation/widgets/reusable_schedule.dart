import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

class ReusableSchedule extends StatelessWidget {
  final Map item;

  const ReusableSchedule({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: item['taskColor'] == 'Color(0XFFFF5147)'
              ? const Color(0XFFFF5147).withOpacity(0.2)
              : item['taskColor'] == 'Color(0XFFFF9D42)'
                  ? const Color(0XFFFF9D42).withOpacity(0.2)
                  : item['taskColor'] == 'Color(0XFFF9C50B)'
                      ? const Color(0XFFF9C50B).withOpacity(0.2)
                      : const Color(0XFF42A0FF).withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: item['taskColor'] == 'Color(0XFFFF5147)'
                        ? const Color(0XFFFF5147)
                        : item['taskColor'] == 'Color(0XFFFF9D42)'
                            ? const Color(0XFFFF9D42)
                            : item['taskColor'] == 'Color(0XFFF9C50B)'
                                ? const Color(0XFFF9C50B)
                                : const Color(0XFF42A0FF),
                    width: 5,
                    style: BorderStyle.solid),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        color: item['taskColor'] == 'Color(0XFFFF5147)'
                            ? const Color(0XFFFF5147)
                            : item['taskColor'] == 'Color(0XFFFF9D42)'
                                ? const Color(0XFFFF9D42)
                                : item['taskColor'] == 'Color(0XFFF9C50B)'
                                    ? const Color(0XFFF9C50B)
                                    : const Color(0XFF42A0FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item['startTime'],
                      style: const TextStyle(
                        color: kLightBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item['description'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
