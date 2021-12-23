import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_management_clean_arch/domain/entities/todo.dart';

class DailyTask {
  final String id;
  final DateTime date;
  final List<Todo> todos;

  DailyTask(
    this.id,
    this.date,
    this.todos,
  );

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'todos': List.from(todos.map((e) => e.toJson())),
    };
  }

  DailyTask.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        date = DateTime.parse(json['date']),
        todos = List.from(
          json['todos'].map(
            (e) => Todo.fromJson(e),
          ),
        );

  String get total {
    var total = 0;
    todos.forEach((element) {
      total += element.endingTime.difference(element.startingTime).inMinutes;
    });
    final int hour = total ~/ 60;
    final int minutes = total % 60;
    if (minutes == 0) return '$hour hours';
    return '$hour hours and $minutes minutes in a day';
  }
}
