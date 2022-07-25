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
          color: item['taskColor'] == 'Color(0XFFFF5147)' ? const Color(0XFFFF5147) : item['taskColor'] ==
              'Color(0XFFFF9D42)' ? const Color(0XFFFF9D42) : item['taskColor'] == 'Color(0XFFF9C50B)'
              ? const Color(0XFFF9C50B)
              : const Color(0XFF42A0FF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['startTime'],
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item['title'],
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
