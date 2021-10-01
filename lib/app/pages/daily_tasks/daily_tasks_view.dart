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

class DailyTasksView extends View {
  @override
  State<StatefulWidget> createState() => _DailyTasksViewState(
        DailyTasksController(
          DataDailyTaskRepository(),
        ),
      );
}

class _DailyTasksViewState
    extends ViewState<DailyTasksView, DailyTasksController> {
  _DailyTasksViewState(DailyTasksController controller) : super(controller);

  Widget get view {
    final Size size = MediaQuery.of(context).size;
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: MainColors.kPrimary,
      key: globalKey,
      body: ControlledWidgetBuilder<DailyTasksController>(
        builder: (context, controller) {
          return controller.dailyTasks == null
              ? Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: MainColors.kPrimary,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: topPadding),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 150,
                        color: MainColors.kPrimary,
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 26, left: 38, right: 22),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 25,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    DateTime.now().day.toString() +
                                        ' ' +
                                        DateUtil.getMonthOFGivenDateTime(
                                          DateTime.now(),
                                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          controller.dailyTasks!.isNotEmpty
                                              ? (controller
                                                      .dailyTasks![controller
                                                          .currentIndex]
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
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 45,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: MainColors.kCream,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                    ),
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
                        child: PageView(
                          onPageChanged: (int page) {
                            controller.currentIndex = page;
                            controller.refreshScreen();
                          },
                          children: [
                            for (int i = 0;
                                i < controller.dailyTasks!.length;
                                i++)
                              _singlePage(size, controller.dailyTasks![i].todos,
                                  controller.dailyTasks![i]),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _singlePage(
    Size size,
    List<Todo> todos,
    DailyTask dailyTask,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: EdgeInsets.only(top: 46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HistoryContainer(
                  date: todos.first.startingTime,
                  isPressed: true,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    dailyTask.total,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
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
                duration: todos[i]
                        .endingTime
                        .difference(todos[i].startingTime)
                        .inMinutes
                        .toString() +
                    ' mins',
              )
          ],
        ),
      ),
    );
  }
}
