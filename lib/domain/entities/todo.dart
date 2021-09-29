class Todo {
  final String id;
  final String title;
  final String text;
  DateTime startingTime;
  DateTime endingTime;

  Todo({
    required this.id,
    required this.title,
    required this.text,
    required this.startingTime,
    required this.endingTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'startingTime': startingTime.toString(),
      'endingTime': endingTime.toString(),
    };
  }

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        startingTime = DateTime.parse(json['startingTime']),
        endingTime = DateTime.parse(json['endingTime']);

  @override
  String toString() => '$id,$text';
}
