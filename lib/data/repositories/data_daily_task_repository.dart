import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';

class DataDailyTaskRepository implements DailyTaskRepository {
  static final _instance = DataDailyTaskRepository._internal();
  DataDailyTaskRepository._internal();
  factory DataDailyTaskRepository() => _instance;

  StreamController<List<DailyTask>> _streamController =
      StreamController.broadcast();

  final _firestore = FirebaseFirestore.instance;
  List<DailyTask> dailyTasks = [];
  bool isDailyTasksFetched = false;

  @override
  void addTodoToDailyTask(Todo todo) {
    if (todo.startingTime.isAfter(todo.endingTime)) {
      DateTime temp = todo.startingTime;
      todo.startingTime = todo.endingTime;
      todo.endingTime = temp;
    }

    if (dailyTasks.isEmpty ||
        dailyTasks
            .every((element) => element.date.day != todo.startingTime.day)) {
      final dailyTaskToAdd =
          DailyTask(DateTime.now().toString(), todo.startingTime, [todo]);
      _firestore.collection('dailyTasks').doc().set(dailyTaskToAdd.toJson());
      dailyTasks.add(dailyTaskToAdd);
    } else {
      DailyTask dailyTaskToAdd = dailyTasks
          .firstWhere((element) => element.date.day == todo.startingTime.day);
      _firestore.collection('dailyTasks').doc(dailyTaskToAdd.id).update({
        'todos': FieldValue.arrayUnion(
          [todo.toJson()],
        ),
      });
      dailyTaskToAdd.todos.add(todo);
    }
    dailyTasks.sort(
      (a, b) => a.date.day.compareTo(b.date.day),
    );
    _streamController.add(dailyTasks);
  }

  @override
  Stream<List<DailyTask>> getDailyTasks() {
    if (!isDailyTasksFetched) _initializeRepository();
    _streamController.add(dailyTasks);
    return _streamController.stream;
  }

  Future<void> _initializeRepository() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docSnapshots =
        (await _firestore.collection('dailyTasks').get()).docs;

    docSnapshots.forEach((json) {
      dailyTasks.add(DailyTask.fromJson(json));
    });
    _streamController.add(dailyTasks);
    isDailyTasksFetched = true;
  }
}
