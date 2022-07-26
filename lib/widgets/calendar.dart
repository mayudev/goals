import 'package:flutter/material.dart';
import 'package:goals/model/todo.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar(
      {Key? key,
      required this.selectedDate,
      required this.onSelected,
      required this.todos})
      : super(key: key);

  final DateTime selectedDate;
  final Function(DateTime) onSelected;

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: selectedDate,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Default',
      },
      onDaySelected: (date, _) {
        onSelected(date);
      },
      selectedDayPredicate: (day) {
        return day == selectedDate;
      },
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(),
        weekdayStyle: TextStyle(),
      ),
      eventLoader: (date) {
        final count =
            todos.where((todo) => !todo.done && todo.date == date).length;
        return List.generate((count > 3) ? 3 : count, (index) => null);
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        markerDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary),
        weekendTextStyle: const TextStyle(),
        holidayTextStyle: const TextStyle(),
      ),
    );
  }
}
