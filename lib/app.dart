import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:state_management_clean_arch/app/pages/todos/todos_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodosView(),
    );
  }
}
