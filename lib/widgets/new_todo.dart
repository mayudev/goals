import 'package:flutter/material.dart';
import 'package:goals/model/new_todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            'Enter a new task',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 20.0,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        _buildIconBar(),
      ],
    );
  }

  Widget _buildIconBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => delete(),
            icon: const Icon(Icons.delete_forever),
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: TextButton(
              onPressed: () => submit(),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
