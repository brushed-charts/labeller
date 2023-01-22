import 'package:flutter/material.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

class SourceModel with Observable {
  SourceModel(this.preferenceStorage);

  static const defaultInterval = '30m';
  static const defaultSource = 'OANDA:EUR_USD';
  static DateTimeRange get defaultDateRange => DateTimeRange(
      start: DateTime.now().toUtc().subtract(const Duration(days: 3)),
      end: DateTime.now().toUtc());

  final PreferenceIOInterface preferenceStorage;
  var interval = defaultInterval;
  var rawSource = defaultSource;
  var dateRange = defaultDateRange;

  String get broker => rawSource.split(':')[0].toLowerCase();
  String get assetPair => rawSource.split(':')[1].toLowerCase();

  @override
  SourceModel copy() {
    final cp = SourceModel(preferenceStorage);
    cp.rawSource = rawSource;
    cp.interval = interval;
    cp.dateRange = DateTimeRange(
      start: dateRange.start,
      end: dateRange.end,
    );
    return cp;
  }

  Future<void> refresh() async {
    interval = (await preferenceStorage.load('interval')) ?? defaultInterval;
    rawSource = (await preferenceStorage.load('rawSource')) ?? defaultSource;
    final strDateFrom = await preferenceStorage.load('dateFrom');
    final strDateTo = await preferenceStorage.load('dateTo');
    dateRange = _makeDatetimeRange(strDateFrom, strDateTo);
  }

  Future<void> save() async {
    await preferenceStorage.write('interval', interval);
    await preferenceStorage.write('rawSource', rawSource);
    await preferenceStorage.write(
        'dateFrom', dateRange.start.toIso8601String());
    await preferenceStorage.write('dateTo', dateRange.end.toIso8601String());
    notify();
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
