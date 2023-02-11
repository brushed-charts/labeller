import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class TesterObservable implements Observer {
  var isEventTrigger = false;

  TesterObservable({required Observable observableToSubscribe}) {
    observableToSubscribe.subscribe(this);
  }

  @override
  void onObservableEvent(Observable observable) {
    isEventTrigger = true;
  }
}

void main() {
  test("Assert charts state model copy is conform", () {
    final model = ChartStateModel();
    model.updateState(ChartViewState.loading);
    final copiedModel = model.copy();
    expect(model, isNot(equals(copiedModel)));
    expect(copiedModel.state, equals(ChartViewState.loading));
  });

  test("Check that chart state is 'noData' on init", () {
    final model = ChartStateModel();
    expect(model.state, equals(ChartViewState.noData));
  });

  test("Chart state model can be updated", () {
    final model = ChartStateModel();
    model.updateState(ChartViewState.loading);
    expect(model.state, equals(ChartViewState.loading));
  });

  test("Expect chart state model notify when state change", () {
    final model = ChartStateModel();
    final observableTester = TesterObservable(observableToSubscribe: model);
    expect(observableTester.isEventTrigger, isFalse);
    model.updateState(ChartViewState.loading);
    expect(observableTester.isEventTrigger, isTrue);
  });

  test("Test updating state with explanation", () {
    final model = ChartStateModel();
    model.updateState(ChartViewState.error, 'A mock error occured');
    expect(model.explanation, equals('A mock error occured'));
  });

  test(
      "Test updating state with no explanation "
      "result to null explanation", () {
    final model = ChartStateModel();
    model.updateState(ChartViewState.loading);
    expect(model.explanation, isNull);
  });
}
