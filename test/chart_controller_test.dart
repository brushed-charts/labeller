import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/chart_controller.dart';
import 'package:labelling/fragment/fragment_controller.dart';
import 'package:labelling/fragment/fragment_model.dart';
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

class MockFragmentController extends Mock implements FragmentController {}

class MockChartModel extends Mock implements ChartModel {
  @override
  final marketMetadataModel = MockMarketMetadataModel();
}

void main() {
  registerFallbackValue(MarketMetadata(
      "", "", 0, DateTimeRange(start: DateTime.now(), end: DateTime.now())));

  late ChartModel chartModel;
  late MarketQuery mockMarketQuery;
  late ChartService chartService;
  late ChartController chartController;
  late FragmentController mockFragmentController;
  when(() => mockMarketQuery.getJsonPrice(any())).thenAnswer((_) async => {});

  setUp(() {
    chartModel = ChartModel.initWithDefault();
    mockMarketQuery = MockMarketQuery();
    chartService = ChartService(marketQuery: mockMarketQuery);
    mockFragmentController = MockFragmentController();
    chartController = ChartController(
      chartModel: chartModel,
      chartService: chartService,
      // fragmentController: mockFragmentController,
      child: Container(),
    );
  });
  test(
      "Assert the controller call getJsonPrice query "
      "on model market metadata notifications", () async {
    chartModel.marketMetadataModel.notify();
    verify(() => mockMarketQuery.getJsonPrice(any())).called(1);
  });

  test("Assert chart controller add fragments on metadata notification", () {
    chartModel.marketMetadataModel.notify();
    final callResult = verify(() => mockFragmentController.add(captureAny()));
    expect(callResult.callCount, equals(1));
    expect(callResult.captured[0], isInstanceOf<FragmentModel>());
  });
}
