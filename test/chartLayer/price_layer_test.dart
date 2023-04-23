import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/chartLayer/price.dart';
import 'package:labelling/fragment/implementation/candle.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketQuery extends Mock implements MarketQuery {}

class MocKMarketMetadata extends Mock implements MarketMetadata {}

void main() {
  registerFallbackValue(MocKMarketMetadata());
  final marketModel = MarketMetadataModel(PreferenceIO());
  late FragmentModel fragmentModel;
  late MockMarketQuery mockMarketQuery;
  late PriceLayer priceLayer;

  setUp(() {
    fragmentModel = FragmentModel();
    mockMarketQuery = MockMarketQuery();
    priceLayer = PriceLayer(marketModel, fragmentModel, mockMarketQuery);
    when(() => mockMarketQuery.getJsonPrice(any()))
        .thenAnswer((invocation) async => {});
  });

  test(
      "Check that PriceLayer update"
      "the fragment model with a Candle fragment", () async {
    await priceLayer.updateFragmentModel();
    expect(fragmentModel.getByName('candle'), isNotNull);
    expect(fragmentModel.getByName('candle'), isInstanceOf<CandleFragment>());
    // Check if parser is not null because if input map data is null
    // So the parser and visualisation are not created and are null
    expect(fragmentModel.getByName('candle')!.parser, isNotNull);
  });

  test("Check that PriceLayer use marketQuery to get the price", () async {
    await priceLayer.updateFragmentModel();
    verify(() => mockMarketQuery.getJsonPrice(any())).called(1);
  });

  test("Assert PriceLayer update the model on metadata model notify", () async {
    expect(fragmentModel.getByName('candle'), isNull);
    marketModel.notify();
    await Future.delayed(const Duration(milliseconds: 50));
    expect(fragmentModel.getByName('candle'), isNotNull);
  });
}
