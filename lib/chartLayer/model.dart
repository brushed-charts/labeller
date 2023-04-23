import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/observation/observable.dart';
import 'package:logging/logging.dart';

class ChartLayerModel with Observable {
  final _logger = Logger('ChartLayerModel');
  final _layerList = <ChartLayerInterface>[];

  void add(ChartLayerInterface layer) {
    _logger.finest("Add a layer to the chart layer model");
    _layerList.add(layer);
  }

  List<ChartLayerInterface> getAll() {
    return List.from(_layerList);
  }

  @override
  Observable copy() {
    final modelCopy = ChartLayerModel();
    for (final layer in _layerList) {
      modelCopy.add(layer);
    }
    return modelCopy;
  }
}
