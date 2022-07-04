import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Default',
      },
      selectedDayPredicate: (day) {
        final now = DateTime.now();
        final today = DateTime.utc(now.year, now.month, now.day);
        return day == today;
      },
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(),
        weekdayStyle: TextStyle(),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30.0),
        ),
        weekendTextStyle: const TextStyle(),
        holidayTextStyle: const TextStyle(),
      ),
    );
  }
}
