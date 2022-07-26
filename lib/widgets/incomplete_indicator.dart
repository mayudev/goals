import 'package:flutter/material.dart';
import 'package:goals/pages/overdue.dart';
import 'package:goals/util/today.dart';

class IncompleteIndicator extends StatelessWidget {
  const IncompleteIndicator(
      {Key? key, required this.count, required this.onReturn})
      : super(key: key);

  final int count;

  final Function(DateTime target) onReturn;

  @override
  Widget build(BuildContext context) {
    final lastPart = count == 1 ? 'task' : 'tasks';

    return ListTile(
      onTap: () async {
        final today = getTodayTimestamp();

        final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => OverduePage(today: today)));

        try {
          // this will fail and do nothing if no DateTime was returned
          final target = result as DateTime;
          onReturn(target);
        } catch (e) {}
      },
      title: Center(
        child: Text.rich(TextSpan(
          text: 'You have ',
          children: [
            TextSpan(
              text: count.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            TextSpan(text: ' overdue $lastPart!'),
          ],
        )),
      ),
    );
  }
}
