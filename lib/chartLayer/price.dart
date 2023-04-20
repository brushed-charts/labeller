import 'package:labelling/chartLayer/layer_interface.dart';
import 'package:labelling/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';

abstract class PriceLayer extends ChartLayerInterface {
  PriceLayer({required Observable sourceOfChange, required FragmentModel fragmentDepositBox}) : super(sourceOfChange: sourceOfChange, fragmentDepositBox: fragmentDepositBox);

  

  void onObservableEvent(covariant MarketMetadataModel marketModel) {
    getPrice(marketModel).then((price) => ).catchError(() {});
  }


  Future<Map<String, dynamic>> getPrice(
      MarketMetadataModel marketMetadataModel) async {}
}
