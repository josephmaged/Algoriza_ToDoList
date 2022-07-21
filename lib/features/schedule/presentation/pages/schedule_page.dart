import 'package:flutter/material.dart';
import 'package:to_do_list/features/schedule/presentation/widgets/schedule_widget.dart';

class SchedulePage extends StatelessWidget {
  static const String ID = 'SchedulePage';
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScheduleWidget();
  }
}
