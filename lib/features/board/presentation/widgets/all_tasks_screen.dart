import 'package:flutter/material.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_task_tile.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        AppBloc.get(context).getTodoData();
      },
      child: AppBloc.get(context).todoList.isEmpty
          ? Center(
            child: Image.asset(
                'assets/images/no_data.png',
                width: 200,
              ),
          )
          : ListView.builder(
              itemCount: AppBloc.get(context).todoList.length,
              itemBuilder: (context, index) => ReusableTaskTile(
                item: AppBloc.get(context).todoList[index],
              ),
            ),
    );
  }
}
