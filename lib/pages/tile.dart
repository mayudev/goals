import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    Key? key,
    required this.title,
    required this.done,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final bool done;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(title),
      value: done,
      onChanged: (state) => onChanged(),
    );
  }
}
