import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/fragment/implementation/bar.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:logging/logging.dart';

class VolumeLayer extends ChartLayerInterface {
  VolumeLayer(MarketMetadataModel marketMetadataModel,
      FragmentModel fragmentModel, MarketQuery marketQuery)
      : super(
            sourceOfChange: marketMetadataModel,
            fragmentModel: fragmentModel,
            marketQuery: marketQuery);

  @override
  final String id = 'volume';
  final _logger = Logger('VolumeLayer');

  @override
  void onObservableEvent(covariant MarketMetadataModel marketModel) {
    updateFragmentModel();
  }

  Future<Map<String, dynamic>?> _fetchVolume() async {
    _logger.finer("Fetch the volume");
    final marketMetadataModel = sourceOfChange as MarketMetadataModel;
    return marketQuery.getJsonPrice(marketMetadataModel.frozenAttributes);
  }

  @override
  Future<void> updateFragmentModel() async {
    final fragment = BarFragment(id, id,
        (sourceOfChange as MarketMetadataModel).broker, await _fetchVolume());
    _logger.finest("Update the fragment model");
    fragmentModel.upsert(fragment);
  }
}
