import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';

class ReusableTaskTile extends StatelessWidget {
  final Map item;

  const ReusableTaskTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails drag) {
        AppBloc.get(context).deleteTodo(todo: item);
      },
      child: ListTile(
        leading: IconButton(
          icon: item['isCompleted'] == "false"
              ? const Icon(
                  Icons.check_box_outline_blank,
                  color: kPrimaryColor,
                )
              : const Icon(
                  Icons.check_box,
                  color: kPrimaryColor,
                ),
          iconSize: 30,
          onPressed: () {
            if (item['isCompleted'] == "false") {
              AppBloc.get(context).updateCompletedTodo(id: item['id'], completedStatus: "true");
            } else if (item['isCompleted'] == "true") {
              AppBloc.get(context).updateCompletedTodo(id: item['id'], completedStatus: "false");
            }
          },
        ),
        title: Text(
          item['title'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          iconSize: 30,
          icon: item['isFavorite'] == "false" ? const Icon(Icons.favorite_border) : const Icon(Icons.favorite),
          onPressed: () {
            if (item['isFavorite'] == "false") {
              AppBloc.get(context).updateFavoriteTodo(id: item['id'], favStatus: "true");
            } else if (item['isFavorite'] == "true") {
              AppBloc.get(context).updateFavoriteTodo(id: item['id'], favStatus: "false");
            }
          },
        ),
      ),
    );
  }
}
