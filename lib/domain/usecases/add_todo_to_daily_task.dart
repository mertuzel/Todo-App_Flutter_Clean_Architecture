import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';

class AddTodoToDailyTask extends UseCase<void, AddTodoToDailyTaskParams> {
  final DailyTaskRepository _todoRepository;

  AddTodoToDailyTask(this._todoRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      AddTodoToDailyTaskParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      _todoRepository.addTodoToDailyTask(params!.todo);
      logger.finest('AddTodoUseCase successful.');
      controller.close();
    } catch (error, st) {
      logger.severe('AddTodoUseCase unsuccessful.');
      controller.addError(error, st);
    }
    return controller.stream;
  }
}

class AddTodoToDailyTaskParams {
  final Todo todo;

  AddTodoToDailyTaskParams(this.todo);
}
