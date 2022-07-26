import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goals/model/new_todo.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/model/todos.dart';
import 'package:goals/widgets/todo_list.dart';

class OverduePage extends StatefulWidget {
  const OverduePage({Key? key, required this.today}) : super(key: key);

  final int today;

  @override
  State<OverduePage> createState() => _OverduePageState();
}

class _OverduePageState extends State<OverduePage> {
  final todoState = TodoState();

  UnmodifiableListView<Todo> get overdueTodos {
    return UnmodifiableListView(todoState.todos
        .where((element) =>
            !element.done && element.date.millisecondsSinceEpoch < widget.today)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Overdue tasks'),
        ),
        body: TodoList(
          todos: overdueTodos,
          displayDetails: true,
          onUpdated: (index, action) {
            index = todoState.itemAt(overdueTodos[index]);

            if (action == TodoAction.delete) {
              setState(() {
                todoState.markItemDone(index);
              });
            } else if (action == TodoAction.mark) {
              Navigator.pop(context, todoState.todos[index].date);
            }
          },
        ));
  }
}
