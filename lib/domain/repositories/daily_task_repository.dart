import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';

abstract class DailyTaskRepository {
  void addTodoToDailyTask(Todo todo);
  Stream<List<DailyTask>> getDailyTasks();
}
