import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/query/market_metadata.dart';

void main() {
  test(
      "Assert query source contains input source, "
      "interval, date from and date to", () {
    final dateFrom = DateTime.utc(2023, 01, 24, 20, 52);
    final dateTo = DateTime.utc(2023, 01, 27, 22, 52);
    const tenMinutes = 10 * 60;
    final dateTimeRange = DateTimeRange(start: dateFrom, end: dateTo);
    final marketMetadata =
        MarketMetadata("broker", "asset_pairs", tenMinutes, dateTimeRange);
    expect(marketMetadata.broker, equals("broker"));
    expect(marketMetadata.assetPairs, equals("asset_pairs"));
    expect(marketMetadata.intervalInSeconds, equals(tenMinutes));
    expect(marketMetadata.dateRange, equals(dateTimeRange));
  });
}
