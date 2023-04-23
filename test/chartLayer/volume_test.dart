import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/chartLayer/implementation/volume.dart';
import 'package:labelling/fragment/implementation/bar.dart';
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
  late VolumeLayer volumeLayer;

  setUp(() {
    fragmentModel = FragmentModel();
    mockMarketQuery = MockMarketQuery();
    volumeLayer = VolumeLayer(marketModel, fragmentModel, mockMarketQuery);
    when(() => mockMarketQuery.getJsonPrice(any()))
        .thenAnswer((invocation) async => {});
  });

  test(
      "Check that VolumeLayer update"
      "the fragment model with a bar fragment", () async {
    await volumeLayer.updateFragmentModel();
    expect(fragmentModel.getByName('volume'), isNotNull);
    expect(fragmentModel.getByName('volume'), isInstanceOf<BarFragment>());
    // Check if parser is not null because if input map data is null
    // So the parser and visualisation are not created and are null
    expect(fragmentModel.getByName('volume')!.parser, isNotNull);
  });

  test("Check that VolumeLayer use marketQuery to get the volume", () async {
    await volumeLayer.updateFragmentModel();
    verify(() => mockMarketQuery.getJsonPrice(any())).called(1);
  });

  test("Assert VolumeLayer update the model on metadata model notify",
      () async {
    expect(fragmentModel.getByName('volume'), isNull);
    marketModel.notify();
    await Future.delayed(const Duration(milliseconds: 50));
    expect(fragmentModel.getByName('volume'), isNotNull);
  });
}
