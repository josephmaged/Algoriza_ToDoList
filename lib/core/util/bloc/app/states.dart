abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDatabaseInitialized extends AppStates {}

class AppDatabaseTodoCreated extends AppStates {}

class AppDatabaseLoading extends AppStates {}

class AppDatabaseTodo extends AppStates {}

class AppGetScheduleList extends AppStates {}

class AppUpdateTodo extends AppStates {}

class AppSelectColor extends AppStates {}

class AppDeleteTodo extends AppStates {}

class AppDatePicker extends AppStates {}

class AppSelectRepeat extends AppStates {}
