import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/observation/observable.dart';

class ChartLayerModel with Observable {
  final layerList = <ChartLayerInterface>[];
  void add(ChartLayerInterface layer) {
    layerList.add(layer);
  }

  List<ChartLayerInterface> getAll() {
    return List.from(layerList);
  }

  @override
  Observable copy() {
    final modelCopy = ChartLayerModel();
    for (final layer in layerList) {
      modelCopy.add(layer);
    }
    return modelCopy;
  }
}
