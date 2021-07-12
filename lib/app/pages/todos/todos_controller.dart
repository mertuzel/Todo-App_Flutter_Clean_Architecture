import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_presenter.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class TodosController extends Controller {
  final TodosPresenter _presenter;
  TodosController(TodoRepository _todoRepository)
      : _presenter = TodosPresenter(_todoRepository);

  List<Todo> todos = [];

  @override
  void initListeners() {
    _presenter.getTodosOnNext = (List<Todo> response) {
      todos = response;
      refreshUI();
    };
    _presenter.getTodosOnError = (e) {
      print(e);
    };
  }

  @override
  void onInitState() {
    _presenter.getTodos();

    super.onInitState();
  }
}
