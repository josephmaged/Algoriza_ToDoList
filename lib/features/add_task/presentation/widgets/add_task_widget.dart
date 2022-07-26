import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/core/util/bloc/app/cubit.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:to_do_list/core/util/bloc/data/dropdown_items.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_drop_down.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_picker_text.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text_form.dart';
import 'package:to_do_list/features/board/presentation/pages/board_page.dart';
import 'package:to_do_list/features/notification/notificaion_api.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

import 'reusable_color_button.dart';

final _formKey = GlobalKey<FormState>();

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const ReusableText(text: 'Title'),
                            const SizedBox(
                              height: 10,
                            ),
                            ReusableTextForm(
                              textType: TextInputType.name,
                              controller: AppBloc.get(context).titleController,
                              hitText: 'Task Title',
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Please enter Task Title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ReusableText(text: 'Description'),
                            const SizedBox(
                              height: 10,
                            ),
                            ReusableTextForm(
                              textType: TextInputType.multiline,
                              controller: AppBloc.get(context).descriptionController,
                              hitText: 'Task Description',
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Please enter Task Description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ReusableText(text: 'Date'),
                            const SizedBox(
                              height: 10,
                            ),
                            ReusablePickerText(
                              value: AppBloc.get(context).selectedDateString,
                              onTap: () {
                                AppBloc.get(context).date(context);
                              },
                              icon: Icons.keyboard_arrow_down,
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
                                      ReusablePickerText(
                                        value: AppBloc.get(context).selectedStartTime.format(context),
                                        onTap: () {
                                          AppBloc.get(context).selectStartTime(context);
                                        },
                                        icon: Icons.access_time_rounded,
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
                                      ReusablePickerText(
                                        value: AppBloc.get(context).selectedEndTime.format(context),
                                        onTap: () {
                                          AppBloc.get(context).selectEndTime(context);
                                        },
                                        icon: Icons.access_time_rounded,
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
                              height: 20,
                            ),
                            const ReusableText(text: 'Select Task Color'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                ReusableColorButton(
                                  iconCondition: AppBloc.get(context).color1IsSelected == false,
                                  iconColor: const Color(0XFFFF5147),
                                  onPressed: () {
                                    AppBloc.get(context).selectColor1();
                                    AppBloc.get(context).selectedColor = "Color(0XFFFF5147)";
                                  },
                                ),
                                ReusableColorButton(
                                  iconCondition: AppBloc.get(context).color2IsSelected == false,
                                  iconColor: const Color(0XFFFF9D42),
                                  onPressed: () {
                                    AppBloc.get(context).selectColor2();
                                    AppBloc.get(context).selectedColor = "Color(0XFFFF9D42)";
                                  },
                                ),
                                ReusableColorButton(
                                  iconCondition: AppBloc.get(context).color3IsSelected == false,
                                  iconColor: const Color(0XFFF9C50B),
                                  onPressed: () {
                                    AppBloc.get(context).selectColor3();
                                    AppBloc.get(context).selectedColor = "Color(0XFFF9C50B)";
                                  },
                                ),
                                ReusableColorButton(
                                  iconCondition: AppBloc.get(context).color4IsSelected == false,
                                  iconColor: const Color(0XFF42A0FF),
                                  onPressed: () {
                                    AppBloc.get(context).selectColor4();
                                    AppBloc.get(context).selectedColor = "Color(0XFF42A0FF)";
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                    ReusableButton(
                      text: 'Create a Task',
                      onPressed: () {
                        if (AppBloc.get(context).selectedStartTimeString != '' ||
                            AppBloc.get(context).selectedEndTimeString != '') {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            AppBloc.get(context).insertTodoData();
                            Navigator.of(context).pushReplacementNamed(BoardPage.ID);
                          }
                          NotificationApi.showNotifivation(
                            title: AppBloc.get(context).titleController.text,
                            body: AppBloc.get(context).descriptionController.text,
                            scheduledDate: DateTime.now().add(Duration(seconds: 15)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please make sure to select Start Time And End Time')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
