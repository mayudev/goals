import 'package:goals/model/database.dart';
import 'package:goals/model/todo.dart';

abstract class TodoStateBase {
  List<Todo> todos = [];

  void markItemDone(int index) {
    todos[index].done = !todos[index].done;

    TodoHelper.updateTodo(todos[index].id, todos[index]);
  }

  void removeItem(int index) {
    TodoHelper.removeTodo(todos[index]);

    todos.removeAt(index);
  }

  Future<void> addItem(Todo item) async {
    todos.add(item);
    final index = await TodoHelper.insertTodo(item);

    item.id = index;
    todos[todos.length - 1] = item;
  }

  void updateItem(int index, Todo item) {
    TodoHelper.updateTodo(item.id, item);

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

  void set(List<Todo> list) {
    todos = list;
  }

  TodoState._internal();
}
