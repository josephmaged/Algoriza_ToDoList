import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text.dart';
import 'package:to_do_list/features/add_task/presentation/widgets/reusable_text_form.dart';
import 'package:to_do_list/features/widgets/reusable_button.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const ReusableTextForm(
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
                      onTap: () {},
                      child: const ReusableTextForm(
                        hitText: 'Task Date',
                        enabled: false,
                        suffixIcon: Icon(
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
                                onTap: () {},
                                child: const ReusableTextForm(
                                  hitText: '11:00 Am',
                                  enabled: false,
                                  suffixIcon: Icon(
                                    Icons.access_time_rounded,
                                    color: kLightBlackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20,),
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
                                onTap: () {},
                                child: const ReusableTextForm(
                                  hitText: '14:00 Pm',
                                  enabled: false,
                                  suffixIcon: Icon(
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
                    GestureDetector(
                      onTap: () {},
                      child: const ReusableTextForm(
                        hitText: '10 minutes early',
                        enabled: false,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kLightBlackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ReusableText(text: 'Repeat'),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const ReusableTextForm(
                        hitText: 'Weekly',
                        enabled: false,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kLightBlackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
            ReusableButton(text: 'Create a Task', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
