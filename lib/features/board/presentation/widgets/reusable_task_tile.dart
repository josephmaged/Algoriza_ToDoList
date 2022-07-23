import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';

class ReusableTaskTile extends StatelessWidget {
  final Map item;

  const ReusableTaskTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: item['isCompleted'] == "false" ? Icon(Icons.check_box_outline_blank) : Icon(Icons.check_box),
        onPressed: () {
          if (item['isCompleted'] == "false") {
            AppBloc.get(context).updateCompletedTodo(id: item['id'], completedStatus: "true");
          } else if (item['isCompleted'] == "true") {
            AppBloc.get(context).updateCompletedTodo(id: item['id'], completedStatus: "false");
          }
        },
      ),
      title: Text(item['title']),
      trailing: IconButton(
        icon: item['isFavorite'] == "false" ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
        onPressed: () {
          if (item['isFavorite'] == "false") {
            AppBloc.get(context).updateFavoriteTodo(id: item['id'], favStatus: "true");
          } else if (item['isFavorite'] == "true") {
            AppBloc.get(context).updateFavoriteTodo(id: item['id'], favStatus: "false");
          }
        },
      ),
    );
  }
}
