import 'dart:async';

import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class DataTodoRepository implements TodoRepository {
  static final _instance = DataTodoRepository._internal();
  DataTodoRepository._internal();
  factory DataTodoRepository() => _instance;

  StreamController<List<DailyTask>> _streamController =
      StreamController.broadcast();

  List<DailyTask> dailyTasks = [
    DailyTask(
      '1',
      DateTime.now(),
      [
        Todo(
            id: '1', text: '1', title: '1', durationHour: 1, durationMinute: 1),
        Todo(
            id: '2',
            text: '312312',
            title: '1231',
            durationHour: 1123,
            durationMinute: 121),
      ],
    ),
    DailyTask(
      '1',
      DateTime.now(),
      [
        Todo(
            id: '1', text: '1', title: '1', durationHour: 1, durationMinute: 1),
        Todo(
            id: '2',
            text: '312312',
            title: '1231',
            durationHour: 1123,
            durationMinute: 121),
      ],
    ),
  ];

  @override
  void addTodo(Todo todo) {}

  @override
  Stream<List<DailyTask>> getDailyTasks() {
    Future.delayed(Duration.zero).then(
      (_) => _streamController.add(
        dailyTasks,
      ),
    );
    return _streamController.stream;
  }
}
