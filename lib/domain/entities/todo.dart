class Todo {
  final String id;
  final String title;
  final String text;
  final DateTime startingTime;
  final DateTime endingTime;

  Todo({
    required this.id,
    required this.title,
    required this.text,
    required this.startingTime,
    required this.endingTime,
  });

  @override
  String toString() => '$id,$text';
}
