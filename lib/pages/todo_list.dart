import 'package:flutter/material.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/pages/tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key, required this.todos, required this.onSwitched})
      : super(key: key);

  final List<Todo> todos;
  final Function(int index) onSwitched;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];
        return TodoListTile(
            title: item.title,
            done: item.done,
            onChanged: () {
              onSwitched(index);
            });
      },
    );
  }
}
