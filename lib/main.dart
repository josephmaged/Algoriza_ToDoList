import 'package:flutter/material.dart';
import 'package:to_do_list/features/add_task/presentation/pages/add_task_page.dart';
import 'package:to_do_list/features/board/presentation/pages/board_page.dart';
import 'package:to_do_list/features/on_boarding/presentation/pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        OnBoardingPage.ID: (context) => const OnBoardingPage(),
        BoardPage.ID: (context) => const BoardPage(),
        AddTaskPage.ID: (context) => const AddTaskPage(),
      },
      home: const OnBoardingPage(),
    );
  }
}
