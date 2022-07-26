DateTime getToday() {
  final now = DateTime.now();
  final today = DateTime.utc(now.year, now.month, now.day);

  return today;
}

int getTodayTimestamp() {
  return getToday().millisecondsSinceEpoch;
}
