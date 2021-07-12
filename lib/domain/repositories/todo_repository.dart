import 'package:state_management_clean_arch/domain/entities/todo.dart';

abstract class TodoRepository {
  void addTodo(Todo todo);
  Stream<List<Todo>> getTodos();
}
