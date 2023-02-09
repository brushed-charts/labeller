import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class ChartController implements Observer {
  ChartController(ChartModel chartModel, MarketQuery marketQuery)
      : _chartModel = chartModel,
        _marketQuery = marketQuery {
    _chartModel.marketMetadataModel.subscribe(this);
  }

  final ChartModel _chartModel;
  final MarketQuery _marketQuery;

  void onMarketMetadataChange() async {
    final queryMetadataMarket = MarketMetadata(
        _chartModel.marketMetadataModel.broker,
        _chartModel.marketMetadataModel.assetPair,
        _chartModel.marketMetadataModel.intervalToSeconds,
        _chartModel.marketMetadataModel.dateRange);
    _marketQuery.getJsonPrice(queryMetadataMarket);
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! MarketMetadataModel) return;
    onMarketMetadataChange();
  }
}
