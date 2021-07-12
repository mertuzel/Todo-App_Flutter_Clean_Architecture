import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_view.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_view.dart';

class HomeController extends Controller {
  final PageController pageController = PageController();
  final List<Widget> screens = [
    TodosView(),
    AddTodoView(),
  ];
  int selectedIndex = 0;

  void onPageChanged(int index) {
    selectedIndex = index;
    refreshUI();
  }

  @override
  void initListeners() {}
}
