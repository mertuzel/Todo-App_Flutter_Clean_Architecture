import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/constants.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_controller.dart';
import 'package:state_management_clean_arch/app/widgets/history_container.dart';
import 'package:state_management_clean_arch/app/widgets/todo_container.dart';
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
    final Size size = MediaQuery.of(context).size;
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: MainColors.kPrimary,
      key: globalKey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 150,
              color: MainColors.kPrimary,
              child: Container(
                padding: EdgeInsets.only(top: 26, left: 38, right: 22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.history,
                          size: 25,
                          color: Colors.transparent,
                        ),
                        Text(
                          '5 May',
                          style: TextStyle(
                            color: MainColors.kCream,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.history,
                          size: 25,
                          color: MainColors.kCream,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                  color: MainColors.kCream,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '8 tasks',
                                style: TextStyle(
                                  color: MainColors.kCream,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          ControlledWidgetBuilder<TodosController>(
                              builder: (context, controller) {
                            return Container(
                              height: 45,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MainColors.kCream,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  controller.navigateToAddTodoPage();
                                },
                                child: Text(
                                  'Add new',
                                  style: TextStyle(
                                    color: MainColors.kPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.09),
                        blurRadius: 4,
                        offset: Offset(-2, -4))
                  ]),
              height: size.height - 150 - topPadding,
              width: size.width,
              child: ControlledWidgetBuilder<TodosController>(
                  builder: (context, controller) {
                return PageView(
                  children: [
                    for (int i = 0; i < controller.dailyTasks.length; i++)
                      _singlePage(size),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _singlePage(Size size) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: EdgeInsets.only(top: 46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HistoryContainer(
                  date: '5 May',
                  day: 'Mon',
                  isPressed: true,
                ),
                Container(
                  padding: EdgeInsets.only(right: 71),
                  child: Row(
                    children: [
                      Text(
                        '2 ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'hours and ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '50 ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'mins a day',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TodoContainer(
              duration: '1 hour',
              date: '123',
              isCurrent: true,
              size: size,
              title: 'Buy a pack of coffee',
            ),
            TodoContainer(
              duration: '30 mins',
              date: '123',
              isCurrent: false,
              size: size,
              title: 'Wash the dishes',
            ),
            TodoContainer(
              duration: '30 mins',
              date: '123',
              isCurrent: false,
              size: size,
              title: 'Make a good omlette',
            ),
            TodoContainer(
              duration: '30 mins',
              date: '123',
              isCurrent: false,
              size: size,
              title: 'Watch a good movie',
            ),
            TodoContainer(
              duration: '30 mins',
              date: '123',
              isCurrent: false,
              size: size,
              title: 'Get some sleep',
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
