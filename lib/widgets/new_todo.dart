import 'package:flutter/material.dart';
import 'package:goals/model/new_todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key, this.initial}) : super(key: key);

  final String? initial;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final TextEditingController _value = TextEditingController();

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.initial != null) {
      _value.text = widget.initial!;
    }
  }

  void submit() {
    if (_value.text.isEmpty) return;

    Navigator.pop(
      context,
      TodoUpdate(
        result: Result.created,
        content: _value.text,
      ),
    );
  }

  void delete() {
    Navigator.pop(
      context,
      TodoUpdate(
        result: Result.deleted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogTitle =
        widget.initial == null ? 'Enter a new task' : 'Edit task';

    return AlertDialog(
        title: Text(dialogTitle),
        content: Builder(builder: (context) {
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: TextField(
                autofocus: true,
                controller: _value,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    gapPadding: 6.0,
                  ),
                ),
                onSubmitted: (value) => submit(),
              ),
            ),
          );
        }),
        actions: [
          Row(
            children: [
              if (widget.initial != null)
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => delete(),
                  icon: const Icon(Icons.delete_forever),
                ),
              Expanded(
                child: TextButton(
                  onPressed: () => submit(),
                  child: const Text('Save'),
                ),
              )
            ],
          )
        ]);
  }
}
