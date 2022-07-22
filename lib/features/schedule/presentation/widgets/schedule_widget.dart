import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';


class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Schedule',
          style: TextStyle(color: kBlackColor),
        ),
        foregroundColor: kBlackColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 15,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        shape: const Border(
          bottom: BorderSide(color: kLightColor, width: 2),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: AnimatedHorizontalCalendar(
              tableCalenderIcon: const Icon(Icons.calendar_today),
              date: DateTime.now(),
              tableCalenderButtonColor: kSecondaryColor,
              selectedBoxShadow: const BoxShadow(color: kSecondaryColor),
              unSelectedBoxShadow: const BoxShadow(
                color: kSecondaryColor,
              ),
              onDateSelected: (date) {},
            ),
          ),
          Positioned(
            top: 105,
            width: MediaQuery.of(context).size.width,
            child: const Divider(
              thickness: 2,
              color: kLightColor,
            ),
          ),
          Positioned(
            top: 150,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
