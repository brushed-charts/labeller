import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/chartLayer/interface.dart';
import 'package:labelling/chartLayer/model.dart';

class FakeChartLayer extends Fake implements ChartLayerInterface {}

void main() {
  test("Assert layer can be added to ChartLayerModel", () {
    final model = ChartLayerModel();
    expect(model.getAll().length, equals(0));
    model.add(FakeChartLayer());
    expect(model.getAll().length, equals(1));
  });

  test("Check that ChartLayerModel getAll return a copy", () {
    final model = ChartLayerModel();
    final layersCopy = model.getAll();
    expect(layersCopy.length, equals(0));
    model.add(FakeChartLayer());
    expect(layersCopy.length, equals(0));
  });

  test("Check that ChartLayerModel can return a model copy", () {
    final model = ChartLayerModel();
    model.add(FakeChartLayer());
    final modelCopy = model.copy() as ChartLayerModel;
    model.add(FakeChartLayer());
    expect(modelCopy.getAll().length, equals(1));
    expect(model.getAll().length, equals(2));
  });
}
