import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';
import 'package:state_management_clean_arch/domain/usecases/get_todos.dart';

class TodosPresenter extends Presenter {
  late Function getTodosOnNext;
  late Function getTodosOnError;

  final GetTodos _getTodos;

  TodosPresenter(TodoRepository _todoRepository)
      : _getTodos = GetTodos(_todoRepository);

  void getTodos() {
    _getTodos.execute(_GetTodosObserver(this));
  }

  @override
  void dispose() {
    _getTodos.dispose();
  }
}

class _GetTodosObserver extends Observer<List<Todo>> {
  final TodosPresenter _presenter;

  _GetTodosObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(error) {
    _presenter.getTodosOnError(error);
  }

  @override
  void onNext(List<Todo>? response) {
    _presenter.getTodosOnNext(response);
  }
}
