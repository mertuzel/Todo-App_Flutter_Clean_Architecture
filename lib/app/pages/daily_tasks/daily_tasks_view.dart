import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/constants.dart';
import 'package:state_management_clean_arch/app/pages/daily_tasks/daily_tasks_controller.dart';
import 'package:state_management_clean_arch/app/widgets/history_container.dart';
import 'package:state_management_clean_arch/app/widgets/todo_container.dart';
import 'package:state_management_clean_arch/data/repositories/data_daily_task_repository.dart';
import 'package:state_management_clean_arch/data/utils/date.dart';
import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';

class TodosView extends View {
  @override
  State<StatefulWidget> createState() => _TodosViewState(
        TodosController(
          DataDailyTaskRepository(),
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
                        ControlledWidgetBuilder<TodosController>(
                            builder: (context, controller) {
                          return Text(
                            controller.dailyTasks.isNotEmpty
                                ? controller.dailyTasks[controller.currentIndex]
                                        .date.day
                                        .toString() +
                                    ' ' +
                                    DateUtil.getMonthOFGivenDateTime(
                                      controller
                                          .dailyTasks[controller.currentIndex]
                                          .date,
                                    )
                                : DateTime.now().day.toString() +
                                    ' ' +
                                    DateUtil.getMonthOFGivenDateTime(
                                      DateTime.now(),
                                    ),
                            style: TextStyle(
                              color: MainColors.kCream,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
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
                              ControlledWidgetBuilder<TodosController>(
                                  builder: (context, controller) {
                                return Text(
                                  controller.dailyTasks.isNotEmpty
                                      ? (controller
                                              .dailyTasks[
                                                  controller.currentIndex]
                                              .todos
                                              .length
                                              .toString() +
                                          ' tasks')
                                      : '0 task',
                                  style: TextStyle(
                                    color: MainColors.kCream,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
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
                  onPageChanged: (int page) {
                    controller.currentIndex = page;
                    controller.refreshScreen();
                  },
                  children: [
                    for (int i = 0; i < controller.dailyTasks.length; i++)
                      _singlePage(size, controller.dailyTasks[i].todos),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _singlePage(Size size, List<Todo> todos) {
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
                  date: todos.first.startingTime,
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
            for (int i = 0; i < todos.length; i++)
              TodoContainer(
                isCurrent: false,
                size: size,
                title: todos[i].title,
                date:
                    '${todos[i].startingTime.hour.toString()}:${todos[i].startingTime.minute.toString()} - ${todos[i].endingTime.hour.toString()}:${todos[i].endingTime.minute.toString()}',
                duration: '30 mins',
              )
          ],
        ),
      ),
    );
  }
}
