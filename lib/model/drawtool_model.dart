import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';

class DrawToolModel {
  DrawToolInterface? _tool;
  DrawToolInterface? get tool => _tool;
  set tool(DrawToolInterface? newTool) {
    _tool = newTool;
  }
}
