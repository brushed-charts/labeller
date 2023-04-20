import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/model/fragment_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

abstract class ChartLayerInterface implements Observer {
  ChartLayerInterface(
      {required this.sourceOfChange, required this.fragmentDepositBox}) {
    sourceOfChange.subscribe(this);
  }

  final Observable sourceOfChange;
  final FragmentModel fragmentDepositBox;

  Future<FragmentInterface> createFragment();
  void pushFragmentToDepositBox(FragmentInterface fragment) {
    fragmentDepositBox.upsert(fragment);
  }
}
