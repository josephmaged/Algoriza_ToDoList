import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/config/const.dart';

import '../../../../core/util/bloc/app/cubit.dart';


class ReusableFrequency extends StatelessWidget {
  const ReusableFrequency({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: kLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Frequency>(
          hint: const Text('Select Repeat'),
          value: AppBloc.get(context).selectedFrequency,
          style: const TextStyle(
            color: kLightBlackColor,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: kLightBlackColor,
          ),
          items: Frequency.values.map((selectedFrequency) {
            return DropdownMenuItem<Frequency>(
              value: selectedFrequency,
              child: Text(
                selectedFrequency.name,
                style: const TextStyle(
                    color: kBlackColor,
                    fontSize: 17,),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            AppBloc.get(context).selectFrequency(newValue);
          },
        ),
      ),
    );
  }
}
