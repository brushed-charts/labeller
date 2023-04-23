import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/query/market_query_contract.dart';

abstract class ChartLayerInterface implements Observer {
  ChartLayerInterface(
      {required this.sourceOfChange,
      required this.fragmentModel,
      required this.marketQuery}) {
    sourceOfChange.subscribe(this);
  }

  final Observable sourceOfChange;
  final FragmentModel fragmentModel;
  final MarketQuery marketQuery;
  abstract final String id;

  void updateFragmentModel();
}
