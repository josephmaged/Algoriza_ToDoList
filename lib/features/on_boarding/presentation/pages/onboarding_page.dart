import 'package:flutter/material.dart';
import 'package:to_do_list/features/on_boarding/presentation/widgets/onboarding_widget.dart';

class OnBoardingPage extends StatelessWidget {
  static const String ID = 'OnBoardingPage';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnBoardingWidget();
  }
}
