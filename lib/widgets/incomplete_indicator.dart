import 'package:flutter/material.dart';

class IncompleteIndicator extends StatelessWidget {
  const IncompleteIndicator({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    final firstPart = count == 1 ? 'is' : 'are';
    final lastPart = count == 1 ? 'task' : 'tasks';

    return ListTile(
      onTap: () {},
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
