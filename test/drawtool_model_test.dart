import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:mocktail/mocktail.dart';

class MockDrawTool extends Mock implements DrawToolInterface {}

class MockObserver extends Mock implements Observer {
  Observable objectToObserve;
  MockObserver(this.objectToObserve) {
    objectToObserve.subscribe(this);
  }
}

void main() {
  registerFallbackValue(DrawToolModel());

  final mockTool = MockDrawTool();
  late DrawToolModel toolModel;
  late MockObserver observer;

  setUp(() {
    toolModel = DrawToolModel();
    observer = MockObserver(toolModel);
  });

  test("DrawTool model notify observer when tool is updated", () {
    toolModel.tool = mockTool;
    final observerCallResult =
        verify(() => observer.onObservableEvent(captureAny()));
    observerCallResult.called(1);
    final parameterCaptured = observerCallResult.captured[0];
    expect(parameterCaptured, equals(toolModel));
  });

  test("DrawTool model can be updated", () {
    toolModel.tool = mockTool;
    expect(toolModel.tool, equals(mockTool));
  });

  test("Expect draw tool to be null on starting", () {
    expect(DrawToolModel().tool, isNull);
  });
}
