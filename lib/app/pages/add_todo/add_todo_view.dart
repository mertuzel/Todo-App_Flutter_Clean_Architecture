import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/constants.dart';
import 'package:state_management_clean_arch/app/pages/add_todo/add_todo_controller.dart';
import 'package:state_management_clean_arch/app/widgets/history_container.dart';
import 'package:state_management_clean_arch/data/repositories/data_todo_repository.dart';

class AddTodoView extends View {
  @override
  State<StatefulWidget> createState() => _AddTodoViewState(
        AddTodoController(
          DataTodoRepository(),
        ),
      );
}

class _AddTodoViewState extends ViewState<AddTodoView, AddTodoController> {
  _AddTodoViewState(AddTodoController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          for (int i = 0; i < 6; i++)
                            GestureDetector(
                              onTap: () {
                                controller.onTapHandler(i);
                              },
                              child: Row(
                                children: [
                                  HistoryContainer(
                                    date: '123',
                                    day: '123',
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
                              'Starts At',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Duration',
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
                            Container(
                              decoration: BoxDecoration(
                                color: MainColors.kLightGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: size.width / 2 - 22,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
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
                              width: size.width / 2 - 22,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
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
                            onPressed: () {},
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
        ),
      ),
    );
  }
}
