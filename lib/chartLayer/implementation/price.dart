import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/fragment/implementation/candle.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/query/market_query_contract.dart';

class PriceLayer extends ChartLayerInterface {
  PriceLayer(MarketMetadataModel marketMetadataModel,
      FragmentModel fragmentModel, MarketQuery marketQuery)
      : super(
            sourceOfChange: marketMetadataModel,
            fragmentModel: fragmentModel,
            marketQuery: marketQuery);

  @override
  final String id = 'price';

  @override
  void onObservableEvent(covariant MarketMetadataModel marketModel) {
    updateFragmentModel();
  }

  Future<Map<String, dynamic>?> _getPrice() async {
    final marketMetadataModel = sourceOfChange as MarketMetadataModel;
    final ohlcPrice =
        await marketQuery.getJsonPrice(marketMetadataModel.frozenAttributes);
    return ohlcPrice;
  }

  @override
  Future<void> updateFragmentModel() async {
    final ohlcPrice = await _getPrice();
    final fragment = CandleFragment(
        'candle', (sourceOfChange as MarketMetadataModel).broker, ohlcPrice);
    fragmentModel.upsert(fragment);
  }
}
