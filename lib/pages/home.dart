import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goals/model/new_todo.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/model/todos.dart';
import 'package:goals/theme.dart';
import 'package:goals/widgets/calendar.dart';
import 'package:goals/widgets/new_todo.dart';
import 'package:goals/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.updateTheme}) : super(key: key);

  Function(ThemeOption) updateTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoState =
      TodoState(); /* [
    Todo(title: 'Done', date: DateTime.utc(2022, 7, 9), done: false),
  ]; */

  late DateTime selectedDate;

  UnmodifiableListView<Todo> get filteredTodos {
    return UnmodifiableListView(todoState.todos
        .where((element) => element.date == selectedDate)
        .toList());
  }

  @override
  void initState() {
    final now = DateTime.now();
    selectedDate = DateTime.utc(now.year, now.month, now.day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.event_available_outlined),
        actions: [
          IconButton(
            onPressed: () => _selectTheme(),
            icon: const Icon(Icons.brightness_6_outlined),
          )
        ],
        title: const Text('Goals'),
      ),
      body: Center(
        child: Column(
          children: [
            Calendar(
              selectedDate: selectedDate,
              onSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            Expanded(
              child: TodoList(
                todos: filteredTodos,
                onUpdated: (index, action) {
                  index = todoState.itemAt(filteredTodos[index]);
                  switch (action) {
                    case TodoAction.mark:
                      setState(() {
                        todoState.markItemDone(index);
                      });
                      break;
                    case TodoAction.delete:
                      setState(() {
                        todoState.removeItem(index);
                      });
                      break;
                    case TodoAction.edit:
                      _editTodo(index);
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTodo() async {
    final todo = await _showTodoModal();

    if (todo?.content != null) {
      setState(() {
        final newTodo =
            Todo(done: false, date: selectedDate, title: todo!.content!);
        todoState.addItem(newTodo);
      });
    }
  }

  Future<void> _editTodo(int index) async {
    final item = todoState.todos[index];

    final result = await _showTodoModal(initial: item.title);

    if (result?.result == Result.created && result?.content != null) {
      setState(() {
        final newTodo = Todo(
          title: result!.content!,
          date: item.date,
          done: item.done,
        );
        todoState.updateItem(index, newTodo);
      });
    } else if (result?.result == Result.deleted) {
      setState(() {
        todoState.removeItem(index);
      });
    }
  }

  Future<TodoUpdate?> _showTodoModal({String? initial}) async {
    final TodoUpdate? todo = await showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: NewTodo(initial: initial),
        );
      },
    );

    return todo;
  }

  Future<void> _selectTheme() async {
    final theme = await _showThemePicker();
    if (theme != null) {
      widget.updateTheme(theme);
    }
  }

  Future<ThemeOption?> _showThemePicker() async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _themeTile(
                  ThemeOption.light, Icons.brightness_5_outlined, 'Light'),
              _themeTile(ThemeOption.dark, Icons.brightness_2_outlined, 'Dark'),
              MaterialButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, null),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _themeTile(ThemeOption theme, IconData icon, String title) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        Navigator.pop(context, theme);
      },
    );
  }
}
