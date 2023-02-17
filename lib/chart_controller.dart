import 'package:flutter/cupertino.dart';
import 'package:labelling/fragment/implementation/candle.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/services/chart_service.dart';
import 'package:logging/logging.dart';

class ChartController extends StatelessWidget implements Observer {
  ChartController({
    Key? key,
    required this.child,
    required this.chartModel,
    required this.chartService,
  }) : super(key: key) {
    chartModel.marketMetadataModel.subscribe(this);
  }

  final ChartModel chartModel;
  final ChartService chartService;
  final Widget child;
  final logger = Logger("ChartController");

  void onMarketMetadataChange() async {
    final queryMetadata = convertModelToMarketMetadataQuery();
    chartModel.stateModel.updateState(ChartViewState.loading);
    final price = await _getOHLCVPrice(queryMetadata);
    if (price == null) return;
    final candleFragment = CandleFragment(
        "candle_ohlc", chartModel.marketMetadataModel.broker, price);
    chartModel.fragmentModel.add(candleFragment);
    chartService.referenceRepository.reset();
    chartModel.stateModel.updateState(ChartViewState.onData);
  }

  Future<Map<String, dynamic>?> _getOHLCVPrice(
      MarketMetadata queryMetadata) async {
    final price = await chartService.marketQuery
        .getJsonPrice(queryMetadata)
        .catchError((err, stacktrace) {
      logger.severe(err.toString(), err, stacktrace);
      chartModel.stateModel.updateState(
          ChartViewState.error, "Error while retrieving JSON Price");
      return null;
    });
    return price;
  }

  MarketMetadata convertModelToMarketMetadataQuery() {
    final queryMetadataMarket = MarketMetadata(
        chartModel.marketMetadataModel.broker,
        chartModel.marketMetadataModel.assetPair,
        chartModel.marketMetadataModel.intervalToSeconds,
        chartModel.marketMetadataModel.dateRange);
    return queryMetadataMarket;
  }

  @override
  void onObservableEvent(Observable observable) async {
    if (observable is! MarketMetadataModel) return;
    onMarketMetadataChange();
  }

  @override
  Widget build(BuildContext context) => child;
}
