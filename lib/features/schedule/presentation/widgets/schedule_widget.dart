import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:to_do_list/features/schedule/presentation/widgets/reusable_schedule.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateOfDay = DateTime.now();
    String dateToDay = DateFormat('EEEE').format(dateOfDay);
    String dateAndDay = DateFormat('d MMM,y').format(dateOfDay);

    return BlocBuilder<AppBloc, AppStates>(
      builder: (context, state) {
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
                  tableCalenderIcon: const Icon(Icons.calendar_month),
                  date: AppBloc.get(context).scheduleInitDate,
                  tableCalenderButtonColor: kSecondaryColor,
                  selectedColor: kPrimaryColor,
                  selectedBoxShadow: const BoxShadow(
                    color: kSecondaryColor,
                  ),
                  unSelectedBoxShadow: const BoxShadow(
                    color: kSecondaryColor,
                  ),
                  onDateSelected: (date) async {
                    dateOfDay = DateTime.parse(date);
                    dateToDay = DateFormat('EEEE').format(dateOfDay);
                    dateAndDay = DateFormat('d MMM,y').format(dateOfDay);
                    AppBloc.get(context).selectedDateString = date;
                    AppBloc.get(context).getScheduleList();
                  },
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateToDay,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(dateAndDay),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AppBloc.get(context).scheduleList.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 150),
                            child: Image.asset(
                              'assets/images/no_data.png',
                              width: 200,
                            ),
                          )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height - 50,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  AppBloc.get(context).getScheduleList();
                                },
                                child: ListView.builder(
                                  itemCount: AppBloc.get(context).scheduleList.length,
                                  itemBuilder: (context, index) => ReusableSchedule(
                                    item: AppBloc.get(context).scheduleList[index],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
