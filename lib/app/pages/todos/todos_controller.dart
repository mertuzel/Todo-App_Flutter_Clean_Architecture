import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_view.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_presenter.dart';
import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class TodosController extends Controller {
  final TodosPresenter _presenter;
  TodosController(TodoRepository _todoRepository)
      : _presenter = TodosPresenter(_todoRepository);

  List<DailyTask> dailyTasks = [];
  bool isPressed = false;

  @override
  void onInitState() {
    _presenter.getDailyTasks();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getDailyTasksOnNext = (List<DailyTask> response) {
      dailyTasks = response;
      refreshUI();
    };
    _presenter.getDailyTasksOnError = (e) {
      print(e);
    };
  }

  void navigateToAddTodoPage() async {
    await Navigator.push(
      getContext(),
      PageTransition(
        child: AddTodoView(),
        curve: Curves.linear,
        duration: Duration(milliseconds: 300),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}
