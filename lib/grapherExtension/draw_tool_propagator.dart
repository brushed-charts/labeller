import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_event.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';

class DrawToolPropagator extends GraphObject with SinglePropagator {
  DrawToolPropagator({required GraphObject child}) {
    this.child = child;
  }

  void propagateDrawTool(DrawToolInterface? drawTool) {
    propagate(DrawToolEvent(drawTool));
  }
}
