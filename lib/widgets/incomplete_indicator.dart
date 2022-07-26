import 'package:flutter/material.dart';
import 'package:goals/pages/overdue.dart';

class IncompleteIndicator extends StatelessWidget {
  const IncompleteIndicator(
      {Key? key, required this.count, required this.onReturn})
      : super(key: key);

  final int count;

  final Function(DateTime target) onReturn;

  @override
  Widget build(BuildContext context) {
    final firstPart = count == 1 ? 'is' : 'are';
    final lastPart = count == 1 ? 'task' : 'tasks';

    return ListTile(
      onTap: () async {
        final now = DateTime.now();
        final today =
            DateTime.utc(now.year, now.month, now.day).millisecondsSinceEpoch;

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
          text: 'There $firstPart ',
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
