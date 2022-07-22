import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:to_do_list/core/util/bloc/data/dropdown_items.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_drop_down.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text_form.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Add Task',
              style: TextStyle(color: kBlackColor),
            ),
            foregroundColor: kBlackColor,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              iconSize: 15,
              icon: const Icon(Icons.arrow_back_ios),
            ),
            shape: const Border(
              bottom: BorderSide(color: kLightColor, width: 2),
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                          text: 'Title',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextForm(
                          controller: AppBloc.get(context).titleController,
                          hitText: 'Task Title',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ReusableText(text: 'Date'),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppBloc.get(context).date(context);
                          },
                          child: ReusableTextForm(
                            controller: AppBloc.get(context).dateController,
                            hitText: AppBloc.get(context).selectedDateString,
                            enabled: false,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(text: 'Start Time'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppBloc.get(context).selectStartTime(context);
                                    },
                                    child: ReusableTextForm(
                                      controller: AppBloc.get(context).startTimeController,
                                      hitText: AppBloc.get(context).selectedStartTime.format(context),
                                      enabled: false,
                                      suffixIcon: const Icon(
                                        Icons.access_time_rounded,
                                        color: kLightBlackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(text: 'End Time'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppBloc.get(context).selectEndTime(context);
                                    },
                                    child: ReusableTextForm(
                                      controller: AppBloc.get(context).endTimeController,
                                      hitText: AppBloc.get(context).selectedEndTime.format(context),
                                      enabled: false,
                                      suffixIcon: const Icon(
                                        Icons.access_time_rounded,
                                        color: kLightBlackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ReusableText(text: 'Remind'),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableDropDown(
                          hint: Text(AppBloc.get(context).reminderController),
                          value: AppBloc.get(context).reminderController,
                          items: remindItems,
                          onChanged: (String? newValue) {
                            AppBloc.get(context).selectRemind(context);
                            AppBloc.get(context).reminderController = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ReusableText(text: 'Repeat'),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableDropDown(
                          hint: Text(AppBloc.get(context).repeatController),
                          value: AppBloc.get(context).repeatController,
                          items: repeatItems,
                          onChanged: (String? newValue) {
                            AppBloc.get(context).selectRepeat(context);
                            AppBloc.get(context).repeatController = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
                ReusableButton(
                  text: 'Create a Task',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
