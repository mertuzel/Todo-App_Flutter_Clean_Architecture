import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_view.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_controller.dart';
import 'package:state_management_clean_arch/data/repositories/data_todo_repository.dart';

class TodosView extends View {
  @override
  State<StatefulWidget> createState() => _TodosViewState(
        TodosController(
          DataTodoRepository(),
        ),
      );
}

class _TodosViewState extends ViewState<TodosView, TodosController> {
  _TodosViewState(TodosController controller) : super(controller);

  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ControlledWidgetBuilder<TodosController>(
                  builder: (context, controller) {
                return Column(
                  children: [
                    for (int i = 0; i < controller.todos.length; i++)
                      Container(
                        child: Text(
                          controller.todos[i].text,
                        ),
                      )
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddTodoView()));
                },
                child: Text(
                  'Go todo page',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
