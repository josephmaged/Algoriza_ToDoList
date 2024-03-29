import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:to_do_list/core/util/model/Task.dart';
import 'package:to_do_list/core/util/services/notification_service.dart';

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
        'CREATE TABLE todo'
        ' (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, startTime TEXT, endTime TEXT, reminder TEXT, repeat TEXT,'
        ' isCompleted TEXT, isFavorite TEXT, taskColor TEXT)',
      );
    }, onOpen: (Database db) {
      database = db;
      getTodoData();
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // TextEditingController dateController = TextEditingController();
  //TextEditingController startTimeController = TextEditingController();
  // TextEditingController endTimeController = TextEditingController();
  //String reminderController = '5';
  String repeatController = "Never";
  bool isCompleted = false;
  bool isFavorite = false;
  String selectedColor = 'Color(0XFFFF5147)';

  final Tasks _tasks = Tasks();


  void insertTodoData() {
    _tasks.title = toBeginningOfSentenceCase(titleController.text);
    _tasks.description = descriptionController.text;
    _tasks.date = selectedDateString;
    _tasks.startTime = selectedStartTimeString;
    _tasks.endTime = selectedEndTimeString;
    _tasks.reminder = reminderString;
    _tasks.repeat = selectedFrequencyString;
    _tasks.isCompleted = isCompleted;
    _tasks.isFavorite = isFavorite;
    _tasks.taskColor = selectedColor;

    database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO todo(title,description,date,startTime,endTime,reminder,repeat,isCompleted,isFavorite,taskColor) VALUES'
        ' ("${_tasks.title}","${_tasks.description}", "${_tasks.date}", "${_tasks.startTime}",'
        ' "${_tasks.endTime}", "${_tasks.reminder}", "${_tasks.repeat}","${_tasks.isCompleted}","${_tasks.isFavorite}","${_tasks.taskColor}")',
      );
    }).then((value) {


      DateTime toUTC = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, selectedStartTime.hour, selectedStartTime.minute - int.parse(reminderString)).toLocal();

      var rng = Random();
      int _randomInt = 0;
      for (var i = 0; i < 10; i++) {
        _randomInt = rng.nextInt(100);
      }

      print(_randomInt);
      NotificationApi.showNotification(
        title: _tasks.title,
        body: _tasks.description,
        id: _randomInt,
        scheduledDate: toUTC,
      );

      titleController.clear();
      descriptionController.clear();
      // dateController.clear();
      selectedDateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      //startTimeController.clear();
      selectedStartTime = TimeOfDay.now();
      //endTimeController.clear();
      selectedEndTime = TimeOfDay.now();
      //reminderController = 'At time of event';
      repeatController = 'Never';

      print(toUTC);
      emit(AppDatabaseTodoCreated());
      getTodoData();
    });
  }

  List<Map> todoList = [];
  List<Map> completedTodoList = [];
  List<Map> unCompletedTodoList = [];
  List<Map> favoriteTodoList = [];
  List<Color> tasksColorList = [];

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

  List<Map> scheduleList = [];

  void getScheduleList() async {
    await database.rawQuery('SELECT * FROM todo WHERE date = ?', [selectedDateString]).then((value) {
      scheduleList = value;

      emit(AppGetScheduleList());
    });
  }

  bool isSelectedCompleted = false;

  void updateCompletedTodo({required int id, required String completedStatus}) async {
    await database.rawUpdate('UPDATE todo SET isCompleted = ? WHERE id = $id', [completedStatus]).then((value) {
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

  void deleteTodo({required Map todo}) async {
    await database.rawDelete('DELETE FROM todo WHERE id = ?', [todo['id']]);
    emit(AppDeleteTodo());
    getTodoData();
  }

  // Select Colors
  bool color1IsSelected = true;
  bool color2IsSelected = false;
  bool color3IsSelected = false;
  bool color4IsSelected = false;

  void selectColor1() {
    // color 1 '0XFFFF5147'
    if (color1IsSelected == false) {
      color1IsSelected = true;
      color2IsSelected = false;
      color3IsSelected = false;
      color4IsSelected = false;
    }
    emit(AppSelectColor());
  }

  void selectColor2() {
    // color 2 '0XFFFF9D42'
    if (color2IsSelected == false) {
      color2IsSelected = true;
      color1IsSelected = false;
      color3IsSelected = false;
      color4IsSelected = false;
    }
    emit(AppSelectColor());
  }

  void selectColor3() {
    // color 3 '0XFFF9C50B'
    if (color3IsSelected == false) {
      color3IsSelected = true;
      color2IsSelected = false;
      color1IsSelected = false;
      color4IsSelected = false;
    }
    emit(AppSelectColor());
  }

  void selectColor4() {
    // color 4 '0XFF42A0FF'
    if (color4IsSelected == false) {
      color4IsSelected = true;
      color2IsSelected = false;
      color3IsSelected = false;
      color1IsSelected = false;
    }
    emit(AppSelectColor());
  }

  // Schedule initial date

  DateTime scheduleInitDate = DateTime.now();

  // Date & Time Picker

  TimeOfDay selectedStartTime = TimeOfDay.now();
  String selectedStartTimeString = '';
  TimeOfDay selectedEndTime = TimeOfDay.now();
  String selectedEndTimeString = '';
  DateTime selectedDate = DateTime.now().toUtc();
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
      selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate);
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
      selectedStartTimeString = selectedStartTime.format(context);
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
      selectedEndTimeString = selectedEndTime.format(context);
    }
    emit(AppDatePicker());
  }

  String reminderString = '0';

  void selectRemind(BuildContext context, newValue) {
    reminderString = newValue;
    emit(AppDatePicker());
  }

/*  String repeatString = "Never";

  void selectRepeat(BuildContext context) {
    repeatController = repeatString;
    emit(AppDatePicker());
  }*/

  // Add to calender
  Frequency? selectedFrequency;
  String? selectedFrequencyString;

  void selectFrequency(Frequency? frequency) {
    selectedFrequency = frequency;
    selectedFrequencyString = selectedFrequency!.name.toString();
    emit(AppSelectRepeat());
  }

 /* Event addEvent({Recurrence? recurrence}) {
    return Event(
      title: titleController.text,
      startDate: DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, selectedStartTime.hour, selectedStartTime.minute),
      endDate: DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, selectedStartTime.hour, selectedStartTime.minute),
      recurrence: Recurrence(
        frequency: selectedFrequency,
        endDate: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, selectedEndTime.hour, selectedEndTime.minute),
      ),
      description: '',
    );
  }*/
}
