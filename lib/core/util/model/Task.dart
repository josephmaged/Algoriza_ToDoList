class Tasks {
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? reminder;
  String? repeat;
  bool? isCompleted;
  bool? isFavorite;
  String? taskColor;

  Tasks({this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.reminder,
    this.repeat,
    this.isCompleted,
    this.isFavorite,
    this.taskColor});

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'description': description,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'reminder': reminder,
        'repeat': repeat,
        'isCompleted': isCompleted,
        'isFavorite': isFavorite,
        'taskColor': taskColor
      };

  Tasks.fromSnapshot(snapshot)

      :title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        date =snapshot.data()['data'],
        startTime = snapshot.data()['startTime'],
        endTime = snapshot.data()['endTime'],
        reminder = snapshot.data()['reminder'],
        repeat = snapshot.data()['repeat'],
        isCompleted = snapshot.data()['isCompleted'],
        isFavorite = snapshot.data()['isFavorite'],
        taskColor = snapshot.data()['taskColor'];
}
