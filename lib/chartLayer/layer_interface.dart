import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/query/market_query_contract.dart';

abstract class ChartLayerInterface implements Observer {
  ChartLayerInterface(
      {required this.sourceOfChange,
      required this.fragmentDepositBox,
      required this.marketQuery}) {
    sourceOfChange.subscribe(this);
  }

  final Observable sourceOfChange;
  final FragmentModel fragmentDepositBox;
  final MarketQuery marketQuery;

  void updateFragmentModel();
}
