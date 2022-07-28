import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/model/Task.dart';

class ReusableTaskTile extends StatelessWidget {
  Map<dynamic, dynamic> item = Tasks().toJson();

  ReusableTaskTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails drag) {
        AppBloc.get(context).deleteTodo(todo: item);
      },
      child: ListTile(
        leading: IconButton(
          icon: item['isCompleted'] == "false"
              ? Icon(
            Icons.check_box_outline_blank,
            color: item['taskColor'] == 'Color(0XFFFF5147)' ? const Color(0XFFFF5147) : item['taskColor'] ==
                'Color(0XFFFF9D42)' ? const Color(0XFFFF9D42) : item['taskColor'] == 'Color(0XFFF9C50B)'
                ? const Color(0XFFF9C50B)
                : const Color(0XFF42A0FF),
          )
              : Icon(
            Icons.check_box,
            color: item['taskColor'] == 'Color(0XFFFF5147)' ? const Color(0XFFFF5147) : item['taskColor'] ==
                'Color(0XFFFF9D42)' ? const Color(0XFFFF9D42) : item['taskColor'] == 'Color(0XFFF9C50B)'
                ? const Color(0XFFF9C50B)
                : const Color(0XFF42A0FF),
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
