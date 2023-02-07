import 'package:labelling/observation/observable.dart';

enum ChartViewState { notReady, noData, loading, error, onData }

class ChartStateModel with Observable {
  ChartViewState state = ChartViewState.notReady;

  @override
  Observable copy() {
    final chartStateModel = ChartStateModel();
    chartStateModel.state = state;
    return chartStateModel;
  }
}
