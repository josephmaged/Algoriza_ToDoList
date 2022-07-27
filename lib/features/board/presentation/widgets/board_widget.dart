// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:to_do_list/features/add_task/presentation/pages/add_task_page.dart';
import 'package:to_do_list/features/board/presentation/widgets/all_tasks_screen.dart';
import 'package:to_do_list/features/board/presentation/widgets/completed_tasks_screen.dart';
import 'package:to_do_list/features/board/presentation/widgets/favorite_tasks_screen.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_tab_selector.dart';
import 'package:to_do_list/features/board/presentation/widgets/uncompleted_tasks_screen.dart';
import 'package:to_do_list/features/schedule/presentation/pages/schedule_page.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppStates>(
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Board',
                style: TextStyle(color: kBlackColor),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    AppBloc.get(context).scheduleInitDate = DateTime.now();
                    AppBloc.get(context).getScheduleList();
                     Navigator.of(context).pushNamed(SchedulePage.ID);
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: kLightBlackColor,
                  ),
                ),
              ],
              shape: const Border(
                bottom: BorderSide(color: kLightColor, width: 1),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: kLightColor, width: 1),
                      )),
                  child: const TabBar(
                    unselectedLabelColor: kLightBlackColor,
                    labelColor: kBlackColor,
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3, color: kPrimaryColor),
                      insets: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    tabs: [
                      ReusableTabSelector(text: "All"),
                      ReusableTabSelector(text: "Completed"),
                      ReusableTabSelector(text: "Uncompleted"),
                      ReusableTabSelector(text: "Favorite"),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 7,
                  right: 20,
                  child: Text(
                    'Swipe left to delete',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TabBarView(
                    children: [
                      AllTasksScreen(),
                      CompletedScreen(),
                      UnCompletedScreen(),
                      FavoriteScreen(),
                    ],
                  ),
                ),
                ReusableButton(
                  text: 'Add a task',
                  onPressed:
                      () /*NotificationApi.showNotifivation(
                    title: 'test',
                    body: 'Hello there'
                  )*/ {
                    AppBloc.get(context).selectedStartTime = TimeOfDay.now();
                    AppBloc.get(context).selectedEndTime = TimeOfDay.now();
                    AppBloc.get(context).selectedDate = DateTime.now().toUtc();
                    Navigator.of(context).pushNamed(AddTaskPage.ID);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
