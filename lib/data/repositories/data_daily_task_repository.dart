import 'dart:async';

import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';

class DataDailyTaskRepository implements DailyTaskRepository {
  static final _instance = DataDailyTaskRepository._internal();
  DataDailyTaskRepository._internal();
  factory DataDailyTaskRepository() => _instance;

  StreamController<List<DailyTask>> _streamController =
      StreamController.broadcast();

  List<DailyTask> dailyTasks = [];

  @override
  void addTodoToDailyTask(Todo todo) {
    if (dailyTasks.isEmpty ||
        dailyTasks
            .every((element) => element.date.day != todo.startingTime.day)) {
      dailyTasks.add(
        DailyTask(DateTime.now().toString(), todo.startingTime, [todo]),
      );
    } else {
      DailyTask dailyTaskToAdd = dailyTasks
          .firstWhere((element) => element.date.day == todo.startingTime.day);
      dailyTaskToAdd.todos.add(todo);
    }
    dailyTasks.sort(
      (a, b) => a.date.day.compareTo(b.date.day),
    );
    _streamController.add(dailyTasks);
  }

  @override
  Stream<List<DailyTask>> getDailyTasks() {
    return _streamController.stream;
  }

  @override
  Future<void> initializeRepository() async {
    // TODO: implement initializeRepository
    throw UnimplementedError();
  }
}
