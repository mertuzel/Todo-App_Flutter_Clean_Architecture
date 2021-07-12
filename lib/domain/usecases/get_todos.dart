import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class GetTodos extends UseCase<List<Todo>, void> {
  final TodoRepository _todoRepository;

  GetTodos(this._todoRepository);
  final StreamController<List<Todo>> _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Todo>?>> buildUseCaseStream(void params) async {
    try {
      _todoRepository.getTodos().listen((List<Todo> todos) {
        _controller.add(todos);
      });
      logger.finest('GetTodosUseCase successful.');
    } catch (e) {
      logger.severe('GetTodosUseCase unsuccessful.');

      _controller.addError(e);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
