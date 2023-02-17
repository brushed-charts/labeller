import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher/reference/memory_repository.dart';
import 'package:labelling/chart_controller.dart';
import 'package:labelling/fragment/fragment_controller.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/chart_state.dart';
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

class MockFragmentResolver extends Mock implements FragmentResolverInterface {}

void main() {
  registerFallbackValue(MarketMetadata(
      "", "", 0, DateTimeRange(start: DateTime.now(), end: DateTime.now())));

  late ChartModel chartModel;
  late MarketQuery mockMarketQuery;
  late ChartService chartService;
  // ignore: unused_local_variable
  late ChartController chartController;

  setUp(() {
    chartModel = ChartModel.initWithDefault();
    mockMarketQuery = MockMarketQuery();
    chartService = ChartService(
        marketQuery: mockMarketQuery,
        referenceRepository: ReferenceRepositoryInMemory());
    chartController = ChartController(
      chartModel: chartModel,
      chartService: chartService,
      child: Container(),
    );
    when(() => mockMarketQuery.getJsonPrice(any())).thenAnswer((_) async => {});
  });
  test(
      "Assert the controller call getJsonPrice query "
      "on model market metadata notifications", () async {
    chartModel.marketMetadataModel.notify();
    verify(() => mockMarketQuery.getJsonPrice(any())).called(1);
  });

  test("Assert chart controller add fragments on metadata notification",
      () async {
    chartModel.marketMetadataModel.notify();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(chartModel.fragmentModel.getAllFragment().length, equals(1));
  });

  test(
      "Assert chart controller update the state "
      "to loading then onData on metadata notification", () async {
    chartModel.marketMetadataModel.notify();
    expect(chartModel.stateModel.state, equals(ChartViewState.loading));
    await Future.delayed(const Duration(milliseconds: 100));
    expect(chartModel.stateModel.state, equals(ChartViewState.onData));
  });
}
