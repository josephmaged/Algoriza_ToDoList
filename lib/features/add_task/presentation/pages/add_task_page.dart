import 'package:flutter/material.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/add_task_widget.dart';
import 'package:to_do_list/features/board/presentation/widgets/board_widget.dart';
import 'package:to_do_list/features/on_boarding/presentation/widgets/onboarding_widget.dart';

class AddTaskPage extends StatelessWidget {
  static const String ID = 'AddTaskPage';

  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddTaskWidget();
  }
}
