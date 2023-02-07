import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/chart_state.dart';

void main() {
  test("Assert charts state model copy is conform", () {
    final model = ChartStateModel();
    model.state = ChartViewState.loading;
    final copiedModel = (model.copy() as ChartStateModel);
    expect(model, isNot(equals(copiedModel)));
    expect(copiedModel.state, equals(ChartViewState.loading));
  });

  test("Check that chart state is 'noData' on init", () {
    final model = ChartStateModel();
    expect(model.state, equals(ChartViewState.noData));
  });
}
