import 'package:flutter/material.dart';
import 'package:labelling/observation/observable.dart';

class SourceModel with Observable {
  var interval = '30m';
  var rawSource = 'OANDA:EUR_USD';
  var dateRange = DateTimeRange(
      start: DateTime.now().toUtc().subtract(const Duration(days: 3)),
      end: DateTime.now().toUtc());

  String get broker => rawSource.split(':')[0].toLowerCase();
  String get assetPair => rawSource.split(':')[1].toLowerCase();

  @override
  SourceModel copy() {
    final cp = SourceModel();
    cp.rawSource = rawSource;
    cp.interval = interval;
    cp.dateRange = DateTimeRange(
      start: dateRange.start,
      end: dateRange.end,
    );
    return cp;
  }
}
