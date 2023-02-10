import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/query/graphql/gql_price_query.dart';
import 'package:labelling/query/market_metadata.dart';

void main() {
  final dateRange = DateTimeRange(
      start: DateTime.utc(2023, 01, 24, 11, 52),
      end: DateTime.utc(2023, 01, 28, 11, 52));
  final marketMetadata =
      MarketMetadata("A_BROKER_TEST", "ASSET_PAIRS", 20 * 60, dateRange);

  test(
      "GQL Price query have the broker name "
      "and the functiion name in the query body", () {
    final queryStr = const GQLPriceQuery().makeQueryBody(marketMetadata);
    expect(queryStr, contains("a_broker_test")); // alias is in lower case
    expect(queryStr, contains("ohlc_price"));
  });

  test("Assert GQL price query produce expected variables", () {
    final queryVariableMap =
        const GQLPriceQuery().makeVariables(marketMetadata);
    expect(queryVariableMap.containsKey('sourceSelector'), isTrue);
    final sourceVariablesMap = queryVariableMap['sourceSelector'];
    expect(sourceVariablesMap['dateFrom'], equals(dateRange.start));
    expect(sourceVariablesMap['dateTo'], equals(dateRange.end));
    expect(sourceVariablesMap['asset'], equals('ASSET_PAIRS'));
    // in result broker must be transformed to lower case
    expect(sourceVariablesMap['source'], equals('a_broker_test'));
    expect(sourceVariablesMap['granularity'],
        equals(marketMetadata.intervalInSeconds));
  });
}
