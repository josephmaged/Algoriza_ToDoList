import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  late Database database;

  void initDatabase() async {
    var databasePath = await getDatabasesPath();

    String path = join(databasePath, 'todo.db');

    openAppDatabase(path: path);

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({required String path}) async {
    await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, reminder TEXT, repeat TEXT, isCompleted TEXT, isFavorite TEXT)',
      );
    }, onOpen: (Database db) {
      database = db;
      getTodoData();
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String reminderController = 'At time of event';
  String repeatController = "Never";
  bool isCompleted = false;
  bool isFavorite = false;

  void insertTodoData() {
    database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO todo(title,date,startTime,endTime,reminder,repeat,isCompleted,isFavorite) VALUES ("${toBeginningOfSentenceCase(titleController.text)}", "${dateController.text}", "${startTimeController.text}", "${endTimeController.text}", "$reminderController", "$repeatController","$isCompleted","$isFavorite")',
      );
    }).then((value) {
      titleController.clear();
      dateController.clear();
      startTimeController.clear();
      endTimeController.clear();
      reminderController = 'At time of event';
      repeatController = 'Never';

      emit(AppDatabaseTodoCreated());
      getTodoData();
    });
  }

  List<Map> todoList = [];
  List<Map> completedTodoList = [];
  List<Map> unCompletedTodoList = [];
  List<Map> favoriteTodoList = [];

  void getTodoData() async {
    emit(AppDatabaseLoading());

    await database.rawQuery('SELECT * FROM todo').then((value) {
      todoList = value;

      favoriteTodoList.clear();
      completedTodoList.clear();
      unCompletedTodoList.clear();

      value.forEach((element) {
        if (element['isFavorite'] == 'true') {
          favoriteTodoList.add(element);
        }
        if (element['isCompleted'] == 'true') {
          completedTodoList.add(element);
        } else if (element['isCompleted'] == 'false') {
          unCompletedTodoList.add(element);
        }
      });
      emit(AppDatabaseTodo());
    });
  }

  bool isSelectedCompleted = false;

  void updateCompletedTodo({required int id, required String completedStatus}) async {
    await database.rawUpdate(
        'UPDATE todo SET isCompleted = ? WHERE id = $id', [completedStatus]).then((value) {
      getTodoData();
      emit(AppUpdateTodo());
    });
  }

  bool isSelectedFavorite = false;

  void updateFavoriteTodo({required int id, required String favStatus}) async {
    await database.rawUpdate('UPDATE todo SET isFavorite = ? WHERE id = $id', [favStatus]).then((value) {
      getTodoData();
      emit(AppUpdateTodo());
    });
  }

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String selectedDateString = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void date(BuildContext context) async {
    final DateTime? dateOfDay = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (dateOfDay != null && dateOfDay != selectedDate) {
      selectedDate = dateOfDay;
      AppBloc.get(context).dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    emit(AppDatePicker());
  }

  void selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedStartTime) {
      selectedStartTime = timeOfDay;
      AppBloc.get(context).startTimeController.text = selectedStartTime.format(context).toString();
    }
    emit(AppDatePicker());
  }

  void selectEndTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedEndTime) {
      selectedEndTime = timeOfDay;
      AppBloc.get(context).endTimeController.text = selectedEndTime.format(context).toString();
    }
    emit(AppDatePicker());
  }

  String reminderString = 'At time of event';

  void selectRemind(BuildContext context) {
    reminderController = reminderString;
    emit(AppDatePicker());
  }

  String repeatString = "Never";

  void selectRepeat(BuildContext context) {
    repeatController = repeatString;
    emit(AppDatePicker());
  }
}
