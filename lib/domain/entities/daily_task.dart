import 'package:state_management_clean_arch/domain/entities/todo.dart';

class DailyTask {
  final String id;
  final DateTime date;
  final List<Todo> todos;

  DailyTask(
    this.id,
    this.date,
    this.todos,
  );
}
