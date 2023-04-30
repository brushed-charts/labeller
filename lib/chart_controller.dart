// import 'package:firestore_figure_database/context.dart';
// import 'package:firestore_figure_database/initializator.dart';
// import 'package:firestore_figure_database/main.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:grapher_user_draw/figure_database_interface.dart';
// import 'package:grapher_user_draw/store.dart';
// import 'package:labelling/drawTools/figure_from_text_factory.dart';
// import 'package:labelling/fragment/implementation/figure.dart';
// import 'package:labelling/main.dart';
// import 'package:labelling/model/chart_model.dart';
// import 'package:labelling/model/chart_state.dart';
// import 'package:labelling/model/drawtool_model.dart';
// import 'package:labelling/model/market_metadata_model.dart';
// import 'package:labelling/observation/observable.dart';
// import 'package:labelling/observation/observer.dart';
// import 'package:labelling/query/market_metadata.dart';
// import 'package:labelling/services/chart_service.dart';
// import 'package:logging/logging.dart';

// import 'fragment/implementation/candle.dart';

// class ChartController extends StatelessWidget implements Observer {
//   ChartController({
//     Key? key,
//     required this.child,
//     required this.chartModel,
//     required this.chartService,
//   }) : super(key: key) {
//     logger.info("ChartController starting");
//     chartModel.marketMetadataModel.subscribe(this);
//     chartModel.drawToolModel.subscribe(this);
//   }

//   final ChartModel chartModel;
//   final ChartService chartService;
//   final Widget child;
//   final logger = Logger("ChartController");

//   @override
//   void onObservableEvent(Observable observable) {
//     if (observable is MarketMetadataModel) {
//       logger.finer("market metadata model has changed");
//       onMarketMetadataChange();
//     } else if (observable is DrawToolModel) {
//       logger.finer("draw tool model has changed");
//       onDrawToolChange();
//     }
//   }

//   void onMarketMetadataChange() async {
//     final queryMetadata = _convertModelToMarketMetadataQuery();
//     chartModel.stateModel.updateState(ChartViewState.loading);

//     final price = await _getOHLCVPrice(queryMetadata);
//     if (price == null) return;
//     final figureDB = await _createFigureDatabase();
//     chartService.referenceRepository.reset();

//     chartModel.fragmentModel.upsert(CandleFragment(
//         "candle_ohlc", chartModel.marketMetadataModel.broker, price));

//     chartModel.fragmentModel.upsert(FigureFragment("figure_label",
//         FigureStore(), chartService.referenceRepository, figureDB));

//     chartModel.stateModel.updateState(ChartViewState.onData, 'display price');
//   }

//   void onDrawToolChange() {
//     final figureFragment =
//         chartModel.fragmentModel.getByName('figure_label') as FigureFragment;
//     figureFragment.drawTool = chartModel.drawToolModel.tool;
//   }

//   Future<FigureDatabaseInterface> _createFigureDatabase() async {
//     final FigureContext figureContext = FigureContext(
//         chartModel.marketMetadataModel.assetPair,
//         chartModel.marketMetadataModel.broker);

//     final firestoreInstance =
//         await FirestoreInit.getInstanceFromProfil(APP_PROFIL);
//     final figureDatabase = FirestoreFigureDatabase(
//         firestoreInstance, FigureFromTextFactory(), figureContext);
//     return figureDatabase;
//   }

//   Future<Map<String, dynamic>?> _getOHLCVPrice(
//       MarketMetadata queryMetadata) async {
//     final price = await chartService.marketQuery
//         .getJsonPrice(queryMetadata)
//         .catchError((err, stacktrace) {
//       logger.severe(err.toString(), err, stacktrace);
//       chartModel.stateModel.updateState(
//           ChartViewState.error, "Error while retrieving JSON Price");
//       return null;
//     });
//     return price;
//   }

//   MarketMetadata _convertModelToMarketMetadataQuery() {
//     final queryMetadataMarket = MarketMetadata(
//         chartModel.marketMetadataModel.broker,
//         chartModel.marketMetadataModel.assetPair,
//         chartModel.marketMetadataModel.intervalToSeconds,
//         chartModel.marketMetadataModel.dateRange);
//     return queryMetadataMarket;
//   }

//   @override
//   Widget build(BuildContext context) => child;
// }
