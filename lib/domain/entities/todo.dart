class Todo {
  final String id;
  final String title;
  final String text;
  final int durationHour;
  final int durationMinute;

  Todo({
    required this.id,
    required this.title,
    required this.text,
    required this.durationHour,
    required this.durationMinute,
  });

  @override
  String toString() => '$id,$text';
}
