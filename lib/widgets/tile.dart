import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile(
      {Key? key,
      required this.title,
      required this.done,
      required this.onChanged,
      this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;
  final bool done;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        title,
        style: _checkboxStyle(done),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: done,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      onChanged: (state) => onChanged(),
    );
  }

  TextStyle _checkboxStyle(bool done) {
    if (done) {
      return const TextStyle(
        decoration: TextDecoration.lineThrough,
      );
    } else
      return TextStyle();
  }
}
