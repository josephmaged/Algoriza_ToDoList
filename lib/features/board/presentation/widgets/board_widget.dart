import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/features/add_task/presentation/pages/add_task_page.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_tab_selector.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_month,
                color: kLightBlackColor,
              ),
            ),
          ],
          shape: const Border(
            bottom: BorderSide(color: kLightColor,width: 2),
          ),
          bottom: const TabBar(
            unselectedLabelColor: kLightBlackColor,
            labelColor: kBlackColor,
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3,color: kPrimaryColor),
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
        body: Stack(
          children: [
            const TabBarView(
              children: [
                Center(
                  child: Text('Tab 1'),
                ),
                Center(
                  child: Text('Tab 2'),
                ),
                Center(
                  child: Text('Tab 3'),
                ),
                Center(
                  child: Text('Tab 4'),
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
  }
}
