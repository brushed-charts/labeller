import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

final dateRangeProvider = StateNotifierProvider<DateRangeModel, DateTimeRange>(
    (_) => DateRangeModel(PreferenceIO()));

class DateRangeModel extends StateNotifier<DateTimeRange> {
  DateRangeModel(this.preferenceStorage)
      : super(DateRangeModel.defaultDateRange);

  static DateTimeRange get defaultDateRange => DateTimeRange(
      start: DateTime.now().toUtc().subtract(const Duration(days: 3)),
      end: DateTime.now().toUtc());

  final PreferenceIOInterface preferenceStorage;
  bool isLoaded = false;
  DateTimeRange get getDateRange => state;

  void setDateRange(DateTimeRange range) {
    if (!validate(range)) return;
    state = range;
  }

  bool validate(DateTimeRange? range) {
    if (range == null) return false;
    if (range.start.millisecondsSinceEpoch >=
        range.end.millisecondsSinceEpoch) {
      return false;
    }
    return true;
  }

  Future<void> refresh() async {
    final strDateFrom = await preferenceStorage.load('dateFrom');
    final strDateTo = await preferenceStorage.load('dateTo');
    state = _makeDatetimeRange(strDateFrom, strDateTo);
    isLoaded = true;
  }

  Future<void> save() async {
    await preferenceStorage.write('dateFrom', state.start.toIso8601String());
    await preferenceStorage.write('dateTo', state.end.toIso8601String());
  }

  DateTimeRange _makeDatetimeRange(String? strFrom, String? strTo) {
    if (strFrom == null || strTo == null) return defaultDateRange;
    if (strFrom == '' || strTo == '') return defaultDateRange;
    final from = DateTime.parse(strFrom);
    final to = DateTime.parse(strTo);
    final datetimeRange = DateTimeRange(start: from, end: to);
    return datetimeRange;
  }
}
