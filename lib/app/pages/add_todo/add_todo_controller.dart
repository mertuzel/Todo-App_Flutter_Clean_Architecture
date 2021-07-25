import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_presenter.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class AddTodoController extends Controller {
  AddTodoPresenter _presenter;

  AddTodoController(TodoRepository _todoRepository)
      : _presenter = AddTodoPresenter(_todoRepository);

  int selectedIndex = 0;

  @override
  void initListeners() {
    _presenter.addtodoOnComplete = () {};

    _presenter.addtodoOnError = (e) {
      print(e);
    };
  }

  void addTodo(Todo todo) {
    _presenter.addTodo(todo);
  }

  void onTapHandler(int index) {
    selectedIndex = index;
    refreshUI();
  }
}
