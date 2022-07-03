import 'package:flutter/material.dart';
import 'package:goals/model/todo.dart';
import 'package:goals/theme.dart';
import 'package:goals/pages/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.updateTheme}) : super(key: key);

  Function(ThemeOption) updateTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final List<Todo> todos = [
    Todo(title: 'Done', done: false),
  ];

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
        child: TodoList(
          todos: todos,
          onSwitched: (index) {
            setState(() {
              todos[index].done = !todos[index].done;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
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
