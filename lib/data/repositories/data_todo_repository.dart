import 'dart:async';

import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class DataTodoRepository implements TodoRepository {
  static final _instance = DataTodoRepository._internal();
  DataTodoRepository._internal();
  factory DataTodoRepository() => _instance;

  StreamController<List<Todo>> _streamController = StreamController.broadcast();
  List<Todo> todos = [Todo('1', 'Study Math', 'now')];

  @override
  void addTodo(Todo todo) {
    try {
      todos.add(todo);
      _streamController.add(todos);
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<List<Todo>> getTodos() {
    try {
      Future.delayed(Duration.zero).then(
        (_) => _streamController.add(todos),
      );
      return _streamController.stream;
    } catch (e) {
      rethrow;
    }
  }
}
