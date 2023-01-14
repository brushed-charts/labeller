import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:labelling/observation/observable.dart';

class DrawToolModel with Observable {
  DrawToolInterface? _tool;
  DrawToolInterface? get tool => _tool;
  set tool(DrawToolInterface? newTool) {
    _tool = newTool;
    notify();
  }
}
