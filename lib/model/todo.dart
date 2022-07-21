class Todo {
  late int id;
  final String title;
  final DateTime date;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.date,
    required this.done,
  });

  /// Covert a Todo into a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'done': done ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> raw) => Todo(
        id: raw['id'],
        title: raw['title'],
        date: DateTime.parse(raw['date']),
        done: raw['done'] > 0,
      );
}
