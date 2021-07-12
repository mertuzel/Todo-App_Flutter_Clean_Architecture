class Todo {
  final String id;
  final String text;
  final String date;

  Todo(this.id, this.text, this.date);

  @override
  String toString() => '$id,$text,$date';
}
