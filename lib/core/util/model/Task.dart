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

  Tasks(
      {this.title,
      this.description,
      this.date,
      this.startTime,
      this.endTime,
      this.reminder,
      this.repeat,
      this.isCompleted,
      this.isFavorite,
      this.taskColor});

 /* Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'date': date,
    'startTime': startTime,

  }*/
}
