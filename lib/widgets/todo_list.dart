import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goals/model/new_todo.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/widgets/tile.dart';
import 'package:intl/intl.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {Key? key,
      required this.todos,
      required this.onUpdated,
      this.displayDetails = false})
      : super(key: key);

  final List<Todo> todos;
  final Function(int index, TodoAction action) onUpdated;
  final bool displayDetails;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMEd();

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];
        return Dismissible(
          background: Container(color: Theme.of(context).colorScheme.primary),
          key: Key(item.title),
          onDismissed: (direction) {
            onUpdated(index, TodoAction.delete);
          },
          child: GestureDetector(
            onLongPress: () {
              HapticFeedback.lightImpact();
              onUpdated(index, TodoAction.edit);
            },
            child: TodoListTile(
                title: item.title,
                subtitle: displayDetails ? formatter.format(item.date) : null,
                done: item.done,
                onChanged: () {
                  onUpdated(index, TodoAction.mark);
                }),
          ),
        );
      },
    );
  }
}
