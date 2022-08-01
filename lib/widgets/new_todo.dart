import 'package:flutter/material.dart';
import 'package:goals/model/new_todo.dart';
import 'package:goals/util/today.dart';
import 'package:intl/intl.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key, this.initial, this.initialDate}) : super(key: key);

  final String? initial;
  final DateTime? initialDate;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final TextEditingController _value = TextEditingController();
  late DateTime date;

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

    date = widget.initialDate ?? getToday();
  }

  String get formattedDate {
    return DateFormat.yMMMd().format(date);
  }

  void submit() {
    if (_value.text.isEmpty) return;

    Navigator.pop(
      context,
      TodoUpdate(
        result: Result.created,
        content: _value.text,
        date: date,
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
        buttonPadding: EdgeInsets.zero,
        contentPadding:
            const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        content: Builder(builder: (context) {
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                ActionChip(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    avatar: Icon(
                      Icons.schedule,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(formattedDate),
                    onPressed: () => _showDatePicker())
              ],
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

  void _showDatePicker() async {
    var newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.utc(2010, 1, 1),
      lastDate: DateTime.utc(DateTime.now().year + 100, 12, 31),
    );

    if (newDate != null) {
      newDate = DateTime.utc(newDate.year, newDate.month, newDate.day);

      setState(() {
        date = newDate!;
      });
    }
  }
}
