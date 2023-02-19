import 'package:flutter/material.dart';
import 'package:grapher_user_draw/draw_tools/path_tool.dart';

class HeadAndShouldersDrawTool extends PathTool {
  static const toolName = 'head_and_shoulders';

  @override
  int maxLength = 7;

  @override
  String name = HeadAndShouldersDrawTool.toolName;

  @override
  Paint paint = Paint()..color = Colors.blue;
}
