import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_presenter.dart';
import 'package:state_management_clean_arch/data/utils/date.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';

class AddTodoController extends Controller {
  AddTodoPresenter _presenter;

  AddTodoController(DailyTaskRepository _todoRepository)
      : _presenter = AddTodoPresenter(_todoRepository);

  String? title;
  num? startingHour;
  num? startingMinute;
  num? endingHour;
  num? endingMinute;
  String? text;

  List<DateTime> oneWeekDateTimes = DateUtil.next7Days;
  int selectedIndex = 0;

  @override
  void initListeners() {
    _presenter.addtodoOnComplete = () {
      FocusScope.of(getContext()).unfocus();
      Navigator.of(getContext()).pop();
    };

    _presenter.addtodoOnError = (e) {
      print(e);
    };
  }

  void addTodo(Todo todo) {
    _presenter.addTodo(todo);
  }

  void onTapHandler(int index) {
    selectedIndex = index;
    startingHour = null;
    startingMinute = null;
    endingHour = null;
    endingMinute = null;
    refreshUI();
  }

  void refreshScreen() {
    refreshUI();
  }
}
