import 'package:flutter/cupertino.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class ChartController extends StatelessWidget implements Observer {
  ChartController(
      {Key? key,
      required this.child,
      required this.chartModel,
      required this.marketQuery})
      : super(key: key) {
    chartModel.marketMetadataModel.subscribe(this);
  }

  final ChartModel chartModel;
  final MarketQuery marketQuery;
  final Widget child;

  void onMarketMetadataChange() async {
    final queryMetadataMarket = MarketMetadata(
        chartModel.marketMetadataModel.broker,
        chartModel.marketMetadataModel.assetPair,
        chartModel.marketMetadataModel.intervalToSeconds,
        chartModel.marketMetadataModel.dateRange);
    chartModel.stateModel.state = ChartViewState.loading;
    await marketQuery.getJsonPrice(queryMetadataMarket);
    chartModel.stateModel.state = ChartViewState.onData;
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! MarketMetadataModel) return;
    onMarketMetadataChange();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
