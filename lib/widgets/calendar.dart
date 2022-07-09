import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar(
      {Key? key, required this.selectedDate, required this.onSelected})
      : super(key: key);

  final DateTime selectedDate;
  final Function(DateTime) onSelected;

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
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(),
        holidayTextStyle: const TextStyle(),
      ),
    );
  }
}
