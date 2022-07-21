import 'package:flutter/material.dart';
import 'package:to_do_list/features/board/presentation/widgets/board_widget.dart';
import 'package:to_do_list/features/on_boarding/presentation/widgets/onboarding_widget.dart';

class BoardPage extends StatelessWidget {
  static const String ID = 'BoardPage';

  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BoardWidget();
  }
}
