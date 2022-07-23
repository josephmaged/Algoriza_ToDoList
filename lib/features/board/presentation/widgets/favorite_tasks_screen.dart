import 'package:flutter/material.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/features/board/presentation/widgets/reusable_task_tile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 150,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: RefreshIndicator(
            onRefresh: () async {
              AppBloc.get(context).getTodoData();
              print(AppBloc.get(context).todoList);
            },
            child: AppBloc.get(context).favoriteTodoList.isEmpty
                ? Center(
                    child: Image.asset(
                      'assets/images/no_data.png',
                      width: 200,
                    ),
                  )
                : ListView.builder(
                    itemCount: AppBloc.get(context).favoriteTodoList.length,
                    itemBuilder: (context, index) => ReusableTaskTile(
                          item: AppBloc.get(context).favoriteTodoList[index],
                        )),
          )),
    );
  }
}
