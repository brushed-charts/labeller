import 'package:labelling/observation/observable.dart';

enum ChartViewState { noData, loading, error, onData }

class ChartStateModel with Observable {
  var _state = ChartViewState.noData;
  String? _explanation;

  String? get explanation => _explanation;
  ChartViewState get state => _state;

  void updateState(ChartViewState newState, [String? explanation]) {
    _state = newState;
    _explanation = explanation;
    notify();
  }

  @override
  ChartStateModel copy() {
    final chartStateModel = ChartStateModel();
    chartStateModel.updateState(state, _explanation);
    return chartStateModel;
  }
}
