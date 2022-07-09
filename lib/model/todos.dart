import 'package:goals/model/todo.dart';

abstract class TodoStateBase {
  List<Todo> todos = [
    Todo(title: 'Done', date: DateTime.utc(2022, 7, 9), done: false)
  ];

  void markItemDone(int index) {
    todos[index].done = !todos[index].done;
  }

  void removeItem(int index) {
    todos.removeAt(index);
  }

  void addItem(Todo item) {
    todos.add(item);
  }

  void updateItem(int index, Todo item) {
    todos[index] = item;
  }
}

class TodoState extends TodoStateBase {
  static final TodoState _instance = TodoState._internal();

  factory TodoState() {
    return _instance;
  }
  int itemAt(Todo item) {
    return todos.indexOf(item);
  }

  TodoState._internal();
}
