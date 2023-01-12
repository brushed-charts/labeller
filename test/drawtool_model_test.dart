import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:labelling/model/drawtool_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDrawTool extends Mock implements DrawToolInterface {}

void main() {
  test("DrawTool model notify observer when tool is updated", () {
    assert(false);
  });

  test("DrawTool model can be updated", () {
    final model = DrawToolModel();
    final mockTool = MockDrawTool();
    model.tool = mockTool;
    expect(model.tool, equals(mockTool));
  });

  test("Expect draw tool to be null on starting", () {
    expect(DrawToolModel().tool, isNull);
  });
}
