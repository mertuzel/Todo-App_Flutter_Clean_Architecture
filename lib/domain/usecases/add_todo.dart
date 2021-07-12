import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class AddTodo extends UseCase<void, AddTodoParams> {
  final TodoRepository _todoRepository;

  AddTodo(this._todoRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(AddTodoParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      _todoRepository.addTodo(params!.todo);
      logger.finest('AddTodoUseCase successful.');
      controller.close();
    } catch (error, st) {
      logger.severe('AddTodoUseCase unsuccessful.');
      controller.addError(error, st);
    }
    return controller.stream;
  }
}

class AddTodoParams {
  final Todo todo;

  AddTodoParams(this.todo);
}
