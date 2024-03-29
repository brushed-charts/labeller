import 'package:flutter/material.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

class MarketMetadataModel with Observable {
  MarketMetadataModel(this.preferenceStorage);

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
  MarketMetadataModel copy() {
    final cp = MarketMetadataModel(preferenceStorage);
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
    notify();
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

  MarketMetadata get frozenAttributes =>
      MarketMetadata(broker, assetPair, intervalToSeconds, dateRange);

  int get intervalToSeconds {
    final number = int.parse(interval.substring(0, interval.length - 1));
    final unit = interval[interval.length - 1];
    switch (unit) {
      case 's':
        return number;
      case 'm':
        return number * 60;
      case 'h':
        return number * 60 * 60;
      case 'd':
        return number * 24 * 60 * 60;
      case 'w':
        return number * 7 * 24 * 60 * 60;
      case 'M':
        return number * 730 * 60 * 60;
      case 'y':
        return number * 8760 * 60 * 60;
      default:
        throw Exception('Interval has not the right syntax ($interval)');
    }
  }
}
