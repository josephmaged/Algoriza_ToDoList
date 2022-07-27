import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/core/util/services/notification_service.dart';
import 'package:to_do_list/features/add_task/presentation/pages/add_task_page.dart';
import 'package:to_do_list/features/board/presentation/pages/board_page.dart';
import 'package:to_do_list/features/on_boarding/presentation/pages/onboarding_page.dart';
import 'package:to_do_list/features/schedule/presentation/pages/schedule_page.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/util/bloc/app/cubit.dart';

bool? initScreen;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getBool("showHome");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..initDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'To-Do List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          OnBoardingPage.ID: (context) => const OnBoardingPage(),
          BoardPage.ID: (context) => const BoardPage(),
          AddTaskPage.ID: (context) => const AddTaskPage(),
          SchedulePage.ID: (context) => const SchedulePage(),
        },
        home: initScreen == true ? const BoardPage() : const OnBoardingPage(),
      ),
    );
  }
}
