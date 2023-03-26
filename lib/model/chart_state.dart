import 'package:labelling/observation/observable.dart';
import 'package:logging/logging.dart';

enum ChartViewState { noData, loading, error, onData }

class ChartStateModel with Observable {
  var _state = ChartViewState.noData;
  String? _explanation;
  final logger = Logger('ChartStateModel');

  String? get explanation => _explanation;
  ChartViewState get state => _state;

  void updateState(ChartViewState newState, [String? explanation]) {
    _state = newState;
    _explanation = explanation;
    logger.finest('Chart state model has been updated - cause: $explanation');
    notify();
  }

  @override
  ChartStateModel copy() {
    final chartStateModel = ChartStateModel();
    chartStateModel.updateState(state, _explanation);
    return chartStateModel;
  }
}
