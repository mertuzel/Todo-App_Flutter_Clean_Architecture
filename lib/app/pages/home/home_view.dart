import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/app/pages/home/home_controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => _HomeViewState(HomeController());
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    return ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      return Scaffold(
        key: globalKey,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: controller.onPageChanged,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
                color:
                    controller.selectedIndex == 0 ? Colors.green : Colors.grey,
              ),
              title: Text(
                'Todos',
                style: TextStyle(
                    color: controller.selectedIndex == 0
                        ? Colors.green
                        : Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color:
                    controller.selectedIndex == 1 ? Colors.green : Colors.grey,
              ),
              title: Text(
                'Add todo',
                style: TextStyle(
                    color: controller.selectedIndex == 1
                        ? Colors.green
                        : Colors.grey),
              ),
            ),
          ],
        ),
        body: controller.screens[controller.selectedIndex],
      );
    });
  }
}
