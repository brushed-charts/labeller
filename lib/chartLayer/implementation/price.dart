import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/fragment/implementation/candle.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:logging/logging.dart';

class PriceLayer extends ChartLayerInterface {
  PriceLayer(MarketMetadataModel marketMetadataModel,
      FragmentModel fragmentModel, MarketQuery marketQuery)
      : id = '${marketMetadataModel.broker}_$name',
        super(
            sourceOfChange: marketMetadataModel,
            fragmentModel: fragmentModel,
            marketQuery: marketQuery);

  static const name = 'price';
  @override
  final String id;
  final _logger = Logger('PriceLayer');

  @override
  void onObservableEvent(covariant MarketMetadataModel marketModel) {
    updateFragmentModel();
  }

  Future<Map<String, dynamic>?> _getPrice() async {
    _logger.finer("Fetch the market price using market metadata");
    final marketMetadataModel = sourceOfChange as MarketMetadataModel;
    final ohlcPrice =
        await marketQuery.getJsonPrice(marketMetadataModel.frozenAttributes);
    return ohlcPrice;
  }

  @override
  Future<void> updateFragmentModel() async {
    final ohlcPrice = await _getPrice();
    final fragment = CandleFragment(
        rootName: id,
        broker: (sourceOfChange as MarketMetadataModel).broker,
        data: ohlcPrice);
    _logger.finest("Update the fragment model");
    fragmentModel.upsert(fragment);
  }
}
