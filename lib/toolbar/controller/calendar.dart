import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/model/date_range_model.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(dateRangeProvider.notifier).refresh();
    return IconButton(
      onPressed: () async {
        final range = await _onCalendar(context, ref);
        saveIfDateIsCorrect(range, ref);
      },
      iconSize: 25,
      icon: Icon(
        Icons.calendar_today_sharp,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<DateTimeRange?> _onCalendar(
      BuildContext context, WidgetRef ref) async {
    final range = await showDateRangePicker(
        context: context,
        initialDateRange: ref.watch(dateRangeProvider),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());
    return range;
  }

  void saveIfDateIsCorrect(DateTimeRange? range, WidgetRef ref) {
    final dateRangeModel = ref.read(dateRangeProvider.notifier);
    if (!dateRangeModel.validate(range)) return;
    dateRangeModel.setDateRange(range!);
    dateRangeModel.save();
  }
}
