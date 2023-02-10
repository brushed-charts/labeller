import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

class MarketMetadataModel with Observable {
  MarketMetadataModel(this.preferenceStorage);

  static const defaultSource = 'OANDA:EUR_USD';
  final PreferenceIOInterface preferenceStorage;
  String get broker => state.split(':')[0].toLowerCase();
  String get assetPair => state.split(':')[1].toLowerCase();

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
    await preferenceStorage.write('source', state);
  }

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
