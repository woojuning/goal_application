import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentDate extends StateNotifier<DateTime> {
  CurrentDate()
      : super(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));

  void updateDateTime(DateTime date) {
    state = date;
  }
}

final currentDateProvider = StateNotifierProvider<CurrentDate, DateTime>((ref) {
  return CurrentDate();
});
