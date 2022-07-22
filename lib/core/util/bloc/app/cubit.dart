import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/util/bloc/app/states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  Database? database;

  void initDatabase() async {
    var databasePath = await getDatabasesPath();

    String path = join(databasePath, 'todo.db');

    openAppDatabase(path: path);

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({required String path}) async {
    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, reminder TEXT, repeat TEXT)');
    }, onOpen: (Database db) {
      database = db;
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String reminderController = 'At time of event';
  String repeatController = "Never";

  void insertTodoData() {
    database?.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO todo VALUES ("${toBeginningOfSentenceCase(titleController.text)}", "${dateController.text}", "${startTimeController.text}", "${endTimeController.text}", "$reminderController", "$repeatController")');
    }).then((value) {
      titleController.clear();
      dateController.clear();
      startTimeController.clear();
      endTimeController.clear();
      reminderController = 'At time of event';
      repeatController = 'Never';

      emit(AppDatabaseTodoCreated());
    });
  }

  List<Map> todo = [];

  void getTodoData() async {
    emit(AppDatabaseLoading());

    database?.rawQuery('SELECT * FROM todo').then((value) {
      todo = value;
      emit(AppDatabaseTodo());
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
