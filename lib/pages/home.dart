import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goals/model/database.dart';
import 'package:goals/model/new_todo.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/model/todos.dart';
import 'package:goals/theme.dart';
import 'package:goals/util/today.dart';
import 'package:goals/widgets/calendar.dart';
import 'package:goals/widgets/incomplete_indicator.dart';
import 'package:goals/widgets/new_todo.dart';
import 'package:goals/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.updateTheme}) : super(key: key);

  Function(ThemeOption) updateTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoState = TodoState();

  late DateTime selectedDate;
  int today = 0;

  int rightNow = DateTime.now().millisecondsSinceEpoch;

  UnmodifiableListView<Todo> get filteredTodos {
    return UnmodifiableListView(todoState.todos
        .where((element) => element.date == selectedDate)
        .toList());
  }

  int get incompleteTodos {
    return todoState.todos
        .where((element) =>
            !element.done && element.date.millisecondsSinceEpoch < today)
        .length;
  }

  @override
  void initState() {
    initTodos();

    selectedDate = getToday();
    today = selectedDate.millisecondsSinceEpoch;

    super.initState();
  }

  void initTodos() async {
    final todos = await TodoHelper.getTodos();

    setState(() {
      todoState.set(todos);
    });
  }

  void _jumpToToday() {
    setState(() {
      selectedDate = getToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.event_available_outlined),
        actions: [
          IconButton(
            onPressed: () => _jumpToToday(),
            tooltip: "Jump to today",
            icon: const Icon(Icons.calendar_today),
          ),
          IconButton(
            onPressed: () => _selectTheme(),
            tooltip: "Switch theme",
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
              todos: todoState.todos,
              onSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            if (incompleteTodos > 0)
              IncompleteIndicator(
                count: incompleteTodos,
                onReturn: (target) => {
                  setState(() {
                    selectedDate = target;
                  })
                },
              ),
            Expanded(
              child: filteredTodos.length > 0
                  ? TodoList(
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
                    )
                  : Center(child: Text('No tasks for this day.')),
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
    final todo = await _showTodoModal(initialDate: selectedDate);

    if (todo?.content != null) {
      final newTodo = Todo(
          id: 0,
          done: false,
          date: todo!.date ?? selectedDate,
          title: todo.content!);

      setState(() {
        todoState.addItem(newTodo);
      });
    }
  }

  Future<void> _editTodo(int index) async {
    final item = todoState.todos[index];

    final result =
        await _showTodoModal(initial: item.title, initialDate: item.date);

    if (result?.result == Result.created && result?.content != null) {
      print(result!.date);

      setState(() {
        final newTodo = Todo(
          id: item.id,
          title: result!.content!,
          date: result.date ?? item.date,
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

  Future<TodoUpdate?> _showTodoModal(
      {String? initial, DateTime? initialDate}) async {
    final TodoUpdate? todo = await showDialog(
      context: context,
      builder: (BuildContext context) => NewTodo(
        initial: initial,
        initialDate: initialDate,
      ),
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
