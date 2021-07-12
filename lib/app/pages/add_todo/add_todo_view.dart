import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_controller.dart';
import 'package:state_management_clean_arch/data/repositories/data_todo_repository.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';

class AddTodoView extends View {
  @override
  State<StatefulWidget> createState() =>
      _AddTodoViewState(AddTodoController(DataTodoRepository()));
}

class _AddTodoViewState extends ViewState<AddTodoView, AddTodoController> {
  _AddTodoViewState(AddTodoController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              ControlledWidgetBuilder<AddTodoController>(
                  builder: (context, controller) {
                return ElevatedButton(
                    onPressed: () {
                      controller.addTodo(
                        Todo(
                          DateTime.now().toString(),
                          'Develop a project',
                          DateTime.now().toString(),
                        ),
                      );
                    },
                    child: Text('Add todo'));
              }),
            ],
          )),
    );
  }
}
