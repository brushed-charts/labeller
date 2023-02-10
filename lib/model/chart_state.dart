import 'package:labelling/observation/observable.dart';

enum ChartViewState { noData, loading, error, onData }

class ChartStateModel with Observable {
  var _state = ChartViewState.noData;

  ChartViewState get state => _state;
  set state(ChartViewState newState) {
    _state = newState;
    notify();
  }

  @override
  ChartStateModel copy() {
    final chartStateModel = ChartStateModel();
    chartStateModel.state = state;
    return chartStateModel;
  }
}
