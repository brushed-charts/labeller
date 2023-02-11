import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/chart_controller.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:labelling/services/chart_service.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketMetadataModel extends Mock implements MarketMetadataModel {}

class MockMarketQuery extends Mock implements MarketQuery {}

class MockPreferenceIO extends Mock implements PreferenceIO {}

class MockChartModel extends Mock implements ChartModel {
  @override
  final marketMetadataModel = MockMarketMetadataModel();
}

void main() {
  registerFallbackValue(MarketMetadata(
      "", "", 0, DateTimeRange(start: DateTime.now(), end: DateTime.now())));

  final chartModel = ChartModel.initWithDefault();
  final mockMarketQuery = MockMarketQuery();
  final chartService = ChartService(marketQuery: mockMarketQuery);

  when(() => mockMarketQuery.getJsonPrice(any())).thenAnswer((_) async => {});

  test(
      "Assert the controller call getJsonPrice query "
      "on model market metadata notifications", () async {
    final _ = ChartController(
      chartModel: chartModel,
      chartService: chartService,
      child: Container(),
    );
    chartModel.marketMetadataModel.notify();
    verify(() => mockMarketQuery.getJsonPrice(any())).called(1);
  });
}