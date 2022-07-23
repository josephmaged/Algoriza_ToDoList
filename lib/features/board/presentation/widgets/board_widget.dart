import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:to_do_list/features/add_task/presentation/pages/add_task_page.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_tab_selector.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_task_tile.dart';
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
                  onPressed: () => Navigator.of(context).pushNamed(SchedulePage.ID),
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
                  width: MediaQuery.of(context).size.width,
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
                TabBarView(
                  children: [
                    SizedBox(
                      height: 500,
                      width: 150,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              AppBloc.get(context).getTodoData();
                            },
                            child: ListView.builder(
                                itemCount: AppBloc.get(context).todoList.length,
                                itemBuilder: (context, index) => ReusableTaskTile(
                                      item: AppBloc.get(context).todoList[index],
                                    )),
                          )),
                    ),
                    SizedBox(
                      height: 500,
                      width: 150,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              AppBloc.get(context).getTodoData();
                            },
                            child: ListView.builder(
                                itemCount: AppBloc.get(context).completedTodoList.length,
                                itemBuilder: (context, index) => ReusableTaskTile(
                                      item: AppBloc.get(context).completedTodoList[index],
                                    )),
                          )),
                    ),
                    SizedBox(
                      height: 500,
                      width: 150,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              AppBloc.get(context).getTodoData();
                            },
                            child: ListView.builder(
                                itemCount: AppBloc.get(context).unCompletedTodoList.length,
                                itemBuilder: (context, index) => ReusableTaskTile(
                                      item: AppBloc.get(context).unCompletedTodoList[index],
                                    )),
                          )),
                    ),
                    SizedBox(
                      height: 500,
                      width: 150,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              AppBloc.get(context).getTodoData();
                              print(AppBloc.get(context).todoList);
                            },
                            child: ListView.builder(
                                itemCount: AppBloc.get(context).favoriteTodoList.length,
                                itemBuilder: (context, index) => ReusableTaskTile(
                                      item: AppBloc.get(context).favoriteTodoList[index],
                                    )),
                          )),
                    ),
                  ],
                ),
                ReusableButton(
                  text: 'Add a task',
                  onPressed: () => Navigator.of(context).pushNamed(AddTaskPage.ID),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
