import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';
import 'package:state_management_clean_arch/domain/usecases/add_todo_to_daily_task.dart';

class AddTodoPresenter extends Presenter {
  late Function addtodoOnComplete;
  late Function addtodoOnError;

  final AddTodoToDailyTask _addTodo;

  AddTodoPresenter(DailyTaskRepository _todoRepository)
      : _addTodo = AddTodoToDailyTask(_todoRepository);

  void addTodo(Todo todo) {
    _addTodo.execute(_AddTodoObserver(this), AddTodoToDailyTaskParams(todo));
  }

  @override
  void dispose() {
    _addTodo.dispose();
  }
}

class _AddTodoObserver extends Observer<void> {
  final AddTodoPresenter _presenter;

  _AddTodoObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addtodoOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addtodoOnError(e);
  }

  @override
  void onNext(_) {}
}
