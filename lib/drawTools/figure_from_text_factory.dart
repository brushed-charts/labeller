import 'package:firestore_figure_database/figure_converter.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:labelling/drawTools/head_and_shoulders.dart';
import 'package:logging/logging.dart';

class FigureFromTextFactory extends FigureConverter {
  final logger = Logger("figure_from_text_factory");
  @override
  DrawToolInterface guessToolUsingItsName(String name) {
    logger.finest("Look for tool named '$name'. "
        "Try to find to instanciate matching object");

    switch (name) {
      case HeadAndShouldersDrawTool.toolName:
        return HeadAndShouldersDrawTool();
    }
    throw ArgumentError(
        "the tool '$name' is not registered in FigureFromTextFactory. "
        "If you add a new DrawTool class don't forget to add it's name "
        "into FigureFromTextFactory. It will be used by Databases "
        "to transform the loaded text from DB into object in this application");
  }
}
