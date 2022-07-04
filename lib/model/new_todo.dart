enum Result {
  none,
  deleted,
  created,
}

enum TodoAction {
  mark,
  delete,
}

class TodoUpdate {
  final Result result;
  final String? content;

  TodoUpdate({
    required this.result,
    this.content,
  });
}
