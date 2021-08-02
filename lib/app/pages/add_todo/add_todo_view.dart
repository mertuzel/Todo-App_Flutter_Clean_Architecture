import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/constants.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_controller.dart';
import 'package:state_management_clean_arch/app/widgets/history_container.dart';
import 'package:state_management_clean_arch/data/repositories/data_daily_task_repository.dart';
import 'package:state_management_clean_arch/data/utils/date.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';

class AddTodoView extends View {
  @override
  State<StatefulWidget> createState() => _AddTodoViewState(
        AddTodoController(
          DataDailyTaskRepository(),
        ),
      );
}

class _AddTodoViewState extends ViewState<AddTodoView, AddTodoController> {
  _AddTodoViewState(AddTodoController controller) : super(controller);

  @override
  Widget get view {
    TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: ControlledWidgetBuilder<AddTodoController>(
            builder: (context, controller) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: 26,
                  left: 20,
                  right: 20,
                  bottom: 26,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          'Create To Do',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.transparent,
                          ),
                          onPressed: null,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    ControlledWidgetBuilder<AddTodoController>(
                        builder: (context, controller) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < controller.oneWeekDateTimes.length;
                                i++)
                              GestureDetector(
                                onTap: () {
                                  controller.onTapHandler(i);
                                },
                                child: Row(
                                  children: [
                                    HistoryContainer(
                                      date: controller.oneWeekDateTimes[i],
                                      isPressed: i == controller.selectedIndex
                                          ? true
                                          : false,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MainColors.kLightGrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: size.width,
                            child: TextFormField(
                              onChanged: (String text) {
                                controller.title = text;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Starting Time',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Ending Time',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      value: _time,
                                      onChange: (TimeOfDay timeOfDay) {
                                        controller.startingHour =
                                            timeOfDay.hour;
                                        controller.startingMinute =
                                            timeOfDay.minute;
                                      },
                                      disableHour: false,
                                      disableMinute: false,
                                      minMinute: 7,
                                      maxMinute: 56,
                                      is24HrFormat: true,
                                    ),
                                  );
                                },
                                child: Text('Select Time'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      value: _time,
                                      onChange: (TimeOfDay timeOfDay) {
                                        controller.endingHour = timeOfDay.hour;
                                        controller.endingMinute =
                                            timeOfDay.minute;
                                      },
                                      disableHour: false,
                                      disableMinute: false,
                                      minMinute: 7,
                                      maxMinute: 56,
                                      is24HrFormat: true,
                                    ),
                                  );
                                },
                                child: Text('Select Time'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Text',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MainColors.kLightGrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: size.width,
                            child: TextFormField(
                              onChanged: (String text) {
                                controller.text = text;
                              },
                              maxLines: 6,
                              minLines: 5,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: MainColors.kLightGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (controller.text != null &&
                                    controller.title != null &&
                                    controller.startingHour != null &&
                                    controller.endingHour != null)
                                  controller.addTodo(
                                    Todo(
                                      id: DateTime.now().toString(),
                                      text: controller.text!,
                                      title: controller.title!,
                                      startingTime: DateTime(
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .year,
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .month,
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .day,
                                        controller.startingHour!,
                                        controller.startingMinute!,
                                      ),
                                      endingTime: DateTime(
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .year,
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .month,
                                        controller
                                            .oneWeekDateTimes[
                                                controller.selectedIndex]
                                            .day,
                                        controller.endingHour!,
                                        controller.endingMinute!,
                                      ),
                                    ),
                                  );
                              },
                              child: Text(
                                'Add',
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
