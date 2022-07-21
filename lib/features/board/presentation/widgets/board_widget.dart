import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_tab_selector.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

class BoardWidget extends StatelessWidget {
  BoardWidget({Key? key}) : super(key: key);

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
                Icons.search,
                color: kLightBlackColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: kLightBlackColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: kLightBlackColor,
              ),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: kLightBlackColor,
            labelColor: kBlackColor,
            isScrollable: true,
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
            Expanded(
              child: TabBarView(
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
            ),
            ReusableButton(
              text: 'Add a task',
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
